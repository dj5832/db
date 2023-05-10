SELECT sal + nvl(comm, 0) sal_plus_comm
  FROM emp;
  
[ 윈도우 함수 ]
윈도우 함수를 사용하면 행간 연산이 가능해진다.
	==> 일반적으로 풀리지 않는 쿼리를 간단하게 만들 수 있다.
	
[ 분석 함수 ];
SELECT emp.*, 1 sal_rank
  FROM emp
 ORDER BY deptno, sal DESC;

순위를 매길 대상 ==> 부서별 sal

SELECT *
  FROM (
		SELECT LEVEL lv
		  FROM dual
		 CONNECT BY LEVEL <= 14
	   ) a,
	   (
	   	SELECT deptno, COUNT(*) cnt
		  FROM emp
		 GROUP BY deptno
	   ) b
 WHERE a.lv <= b.cnt
 ORDER BY b.deptno, a.lv
;

SELECT ROWNUM rn, a.*
  FROM (
  		SELECT ename, sal, deptno
		  FROM emp
		 ORDER BY deptno, sal DESC
  		) a
;

SELECT ROWNUM rn, b.*
  FROM (
  		SELECT b.deptno, a.lv
		  FROM (
				SELECT LEVEL lv
				  FROM dual
				 CONNECT BY LEVEL <= 14
			   ) a,
			   (
			   	SELECT deptno, COUNT(*) cnt
				  FROM emp
				 GROUP BY deptno
			   ) b
		 WHERE a.lv <= b.cnt
		 ORDER BY b.deptno, a.lv
  		) b
; 



SELECT FIRST.ename, FIRST.sal, FIRST.deptno, LAST.lv
  FROM (
  		SELECT ROWNUM rn, a.*
		  FROM (
		  		SELECT ename, sal, deptno
				  FROM emp
				 ORDER BY deptno, sal DESC
		  		) a
  		) FIRST,
  	   (
  	    SELECT ROWNUM rn, b.*
		  FROM (
		  		SELECT b.deptno, a.lv
				  FROM (
						SELECT LEVEL lv
						  FROM dual
						 CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp)
					   ) a,
					   (
					   	SELECT deptno, COUNT(*) cnt
						  FROM emp
						 GROUP BY deptno
					   ) b
				 WHERE a.lv <= b.cnt
				 ORDER BY b.deptno, a.lv
		  		) b
  	   ) last
 WHERE FIRST.rn = LAST.rn
; 
-------------------------------------------------------------------------
[ 위와 동일한 동작을 하는 윈도우 함수 ]

윈도우 함수를 사용하면 행간 연산이 가능해진다.
	==> 일반적으로 풀리지 않는 쿼리를 간단하게 만들 수 있다.
	** 모든 DBMS가 동일한 윈도우 함수를 제공하지는 않음.
	
문법 : 윈도우 함수 OVER ( [PARTITION BY 컬럼]  [ORDER BY 컬럼] [WINDOWING] )
PARTITION BY - 행들을 묶을 그룹(GROUP BY 와 유사)
ORDER BY - 묶여진 행들간 순서
WINDOWING - 파티션 안에서 특정 행들에 대해서만 연산을 하고 싶을 때 범위를 지정

순위 관련 함수
1. RANK() - 동일 값일 때는 동일 순위 부여, 후순위는 중복자만큼 건너 띄고 부여
			1등이 2명이면 후순위는 3등을 부여한다.
2. DENSE_RANK() - 동일 값일 때는 동일 순위 부여, 후순위는 이어서 부여
			1등이 2명이어도 후순의는 2등을 부여한다.
3. ROW_NUMBER() - 중복되는 값이 없이 순위를 부여(rownum 과 유사)

SELECT ename, sal, deptno,
		RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) sal_rank,
		DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) sal_dense_rank,
		ROW_NUMBER() over(PARTITION BY deptno ORDER BY sal DESC) sal_row_number
  FROM emp;
  
[ 집계 윈도우 함수 ] - sum, max, min, avg, count

SELECT empno, ename, deptno, count(*) OVER( PARTITION BY deptno ) cnt
  FROM emp;
  
-- 실습
 
SELECT empno, ename, sal, deptno, round(avg(sal) OVER( PARTITION BY deptno ), 2)
  FROM emp;
  
SELECT empno, ename, sal, deptno, max(sal) OVER( PARTITION BY deptno ), min(sal) OVER( PARTITION BY deptno) 
  FROM emp;
  
계층쿼리
1. CONNECT BY LEVEL <, <= 정수
	- 시작행, 연결될 다음 행과의 조건이 없음
2. START WITH, CONNECT BY - 일반적인 계층 쿼리(일반 테이블과는 잘 쓰지 않고 dual 테이블과 많이 사용)
						  	시작 행 지정, 연결될 다음 행과의 조건을 기술
						  	
CREATE TABLE imsi ( 
	t varchar2(2)
);

INSERT INTO imsi VALUES ('a');
INSERT INTO imsi VALUES ('b');

select t, LEVEL , ltrim(sys_connect_by_path(t, '-'), '-') path
  FROM imsi
 CONNECT BY LEVEL <= 3;
 
select dummy, LEVEL
  FROM dual
 CONNECT BY LEVEL <= 10;
 
------------------------------------------------------------------------------------------------------------

lag(col) - 파티션별 이전 행의 특정 컬럼 값을 가져오는 함수
lead(col) - 파티션별 이후 행의 특정 컬럼 값을 가져오는 함수

전체 사원의 급여 순위가 자신보다 1단계 낮은 사람의 급여값을 5번째 컬럼으로 생성
(단, 급여가 같을 경우 입사일자가 빠른 사람이 우선순위가 높다.)

select empno, ename, hiredate, sal, 
  FROM emp 
  ORDER BY sal DESC, hiredate;
  
select empno, ename, hiredate, sal,
		lead(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal,
		lag(sal) OVER(ORDER BY sal DESC, hiredate) lag_sal
  FROM emp;