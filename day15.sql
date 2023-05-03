[ GROUP FUNCTION 응용, 확장 ];
select deptno, sum(sal)
  FROM emp 
 GROUP BY deptno
UNION
select NULL, sum(sal)
  FROM emp
 ORDER BY deptno DESC NULLS LAST;
 
ROLLUP - 1. GROUP BY 의 확장 구문
		 2. 정해진 규칙으로 서브 그룹을 생성하고 생성된 서브 그룹을 하나의 집합으로 변환
		 3. GROUP BY ROLLUP(col1, col2...)
		 4. ROLLUP 절에 기술된 컬럼을 오른쪽에서부터 하나씩 제거해 가며 서브그룹을 생성
		 	ROLLUP 의 경우 방향성이 있기 때문에 컬럼 기술 순서가 다르면 다른 결과가 나온다.
		 	
예시 - GROUP BY ROLLUP (deptno)
1. GROUP BY deptno ==> 부서번호별 총계
2. GROUP BY '' ==> 전체 총계

예시 - GROUP BY ROLLUP (job, deptno)
1. GROUP BY job, deptno ==> 담당업무, 부서번호별 총계
2. GROUP BY job		==> 담당업무별 총계
3. GROUP BY ''		==> 전체 총계

select job, deptno, sum(sal + nvl(comm, 0)) sal
  FROM emp
 GROUP BY ROLLUP (job, deptno);
 
select *
  FROM emp;
  
* ROLLUP 절에 N개의 컬럼을 기술 했을 때 SUBGROUP 의 개수는 N + 1 개의 서브 그룹이 생성

GROUPING 함수
GROUPING(column)

job 컬럼이 소계 계산으로 사용되어 NULL 값이 나온 것인지, 정말 컬럼의 값이 NULL 인 행들이
GROUP BY 된 것인지 알려면 GROUPING 함수를 사용해야 정확한 값을 알 수 있다.

select nvl(job, '총계'), deptno, sum(sal + nvl(comm, 0)) sal, GROUPING(job), GROUPING(deptno)
  FROM emp
 GROUP BY ROLLUP (job, deptno);
 
GROUPING(column) - 0, 1
0 - 컬럼이 소계 계산에 사용되지 않았다. (GROUP BY 컬럼으로 사용됨)
1 - 컬럼이 소계 계산에 사용 되었다.

select decode(GROUPING(job), 1, '총계', job) job, decode(GROUPING(deptno), 1, '소계', deptno) deptno, GROUPING(job), GROUPINg(deptno), sum(sal + nvl(comm , 0)) sal
  FROM emp
 GROUP BY ROLLUP (job, deptno);
 
-- 실습1

select decode(GROUPING(job), 1, '총', job) job,
	   decode(GROUPING(deptno) + GROUPING(job), 2,'계', 1, '소계', deptno) deptno,
	   GROUPING(job), GROUPING(deptno), sum(sal + nvl(comm ,0)) sal
	     FROM emp
 GROUP BY ROLLUP (job, deptno);
-- 실습2
	   
SELECT deptno, job, sum(sal + nvl(comm, 0)) sal
  FROM emp
 GROUP BY ROLLUP (deptno, job);

-- 실습3

select dname, job, sum(sal + nvl(e.comm, 0)) sal
  FROM dept d, emp e
 where d.deptno = e.deptno 
 GROUP BY ROLLUP (d.dname, job)
 ORDER BY dname , job desc;
 
--------------------------------------------------------------------------------------------------------------------------------------
확장된 GROUP BY 
1. ROLLUP - 컬럼 기술에 방향성이 존재
	GROUP BY ROLLUP (job, deptno) != GROUP BY ROLLUP (deptno, job)
	GROUP BY job, deptno			 GROUP BY deptno, job
	GROUP BY job					 GROUP BY deptno
	GROUP BY ''						 GROUP BY ''
	단점 - 개발자가 필요가 없는 서브그룹을 임의로 제거할 수 없다.

2. GROUPING SETS - 필요한 서브그룹을 임의로 지정하는 형태
	==> 복수의 GROUP BY 를 하나도 합쳐서 결과를 돌려주는 형태
	GROUP BY GROUPING SETS (col1, col2)
	
	GROUP BY col1
	union all 
	GROUP BY col2
	
	GROUP BY GROUPING SETS (col2, col1)
	
	GROUP BY col2
	union all 
	GROUP BY col1
	
	GROUPING SETS 의 경우 ROLLUP 과는 다르게 컬럼 나열순서가 데이터 자체에 영향을 미치지 않는다.
	
	복수컬럼으로 GROUP BY 
	GROUP BY col1, col2
	UNION ALL 
	GROUP BY col1
	==> GROUPING SETS ((col1, col2), col1)
	
GROUPING SETS 실습

SELECT job, deptno, sum(sal + nvl(comm , 0)) sal
  FROM emp
 GROUP BY GROUPING SETS (job, deptno);
 
위 쿼리를 UNION ALL 로 풀어쓰기

select job, NULL, sum(sal + nvl(comm , 0)) sal
  FROM emp
 GROUP BY job 
 
 UNION ALL 
 select deptno, NULL, sum(sal + nvl(comm , 0)) sal
  FROM emp
 GROUP BY deptno;


3. CUBE
GROUP BY 절을 확장한 구문
CUBE 절에 나열한 모든 가능한 조합으로 서브그룹을 생성
GROUP BY CUBE (job, depno)

GROUP BY job, deptno
GROUP BY job
GROUP BY deptno
GROUP BY ''

select job, deptno, GROUPING(job), GROUPING(deptno), sum(sal + nvl(comm, 0)) sal
  FROM emp
 GROUP BY CUBE (job, deptno);

select job, sum(sal + nvl(comm, 0)) sal
  FROM emp
 GROUP BY ROLLUP(job);


CUBE 의 경우 기술한 컬럼으로 모든 가능한 조합으로 서브그룹을 생성하낟.
가능한 서브구릅은 2^기술한 컬럼갯수
기술한 컬럼이 3ㄱ만 넘어도 생성되는 서브그룹의 개수가 8개가 넘기 때문에 실제 필요하지 않은 서브그룹이
포함될 가능성이 높다 ==> ROLLUP, GROUPING SETS 보다 활용성이 떨어진다.
GROUP BY ROLLUP (job, deptno, mgr)
GROUP BY CUBE   (job, deptmo, mgr)