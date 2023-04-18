-- 논리연산
-- 논리연산자 : AND, OR, NOT
-- AND : 참 거짓 판단식1 AND 참 거짓 판단식2 ==> 식 두개를 동시에 만족하는 행만 참
--	   : 일반적으로 AND 조건이 많이 붙으면 조회되는 행의 수가 줄어든다.
-- OR  : 참 거짓 판단식1 OR 참 거짓 판단식2 ==> 식 두개중에 하나라도 만족하면 참
-- NOT : 조건을 반대로 해석하는 부정형 연산
-- NOT IN : 포함되지 않는것
-- IS NOT NULL : NULL 이 아닌것

SELECT *
	FROM emp
WHERE MGR = 7698 AND sal > 1000;
	
-- emp 테이블에서 mgr 컬럼 값이 7698이면서 sal 컬럼의 값이 1000보다 큰 사원을 조회하세요.
-- 2가지 조건을 동시에 만족하는 사원 리스트

SELECT *
	FROM emp
WHERE MGR = 7698 AND sal > 1000;

-- mgr 값이 7698이거나 sal 값이 1000보다 크거나 두개의 조건을 하나라도 만족하는 행을 조회하세요.

SELECT *
	FROM emp
WHERE MGR = 7698 OR sal > 1000;

-- emp 테이블에서 mgr 컬럼이 7698, 7839가 아닌 사원들을 조회하세요.

SELECT *
	FROM emp
	WHERE mgr NOT IN (7698, 7839)
;

-- mgr 사번이 7698이 아니고, 7839가 아니고, NULL이 아닌 직원들을 조회하세요.

SELECT *
	FROM emp 
	WHERE mgr NOT IN (7698, 7839) AND mgr IS NOT NULL
;

-- mgr 컬럼이 (7698, 7839, NULL)에 포함된다.
-- mgr IN(7698, 7839, NULL); ==> mgr = 7698 OR mgr = 7839 OR mgr = NULL
-- mgr NOT IN(7698, 7839, NULL); ==> mgr != 7698 AND mgr != 7839 AND mgr != NULL
-- 마지막에 mgr != NILL 값이 항상 false 라서 값이 나오지 않는다.

-- mgr NOT IN (7698, 7839)
-- !(mgr = 7698 OR mgr = 7839) ==> (mgr != 7698 AND mgr != 7839)
-- **** mgr 컬럼에 NULL  값이 있을 경우 비교 연산으로 NULL 비교가 불가하기 때문에 NULL을 갖는 행은 무시가 된다.

SELECT *
	FROM emp
;

-- [예제1]
-- emp 테이블에서 job이 SALESMAN이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 조회하세요.
SELECT *
	FROM emp
	WHERE job = 'SALESMAN' AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD')
;
-- [예제2]
-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 조회하세요.
-- IN, NOT IN 연산자 사용금지
SELECT *
	FROM emp
	WHERE deptno != 10 AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD')
;
-- [예제3]
-- [예제2]와 동일 조건을 NOT IN 사용
SELECT *
	FROM emp
	WHERE deptno NOT IN(10) AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD') -- TO_DATE 명시적 형변환
;
-- [예제4]
-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 조회하세요.
-- 부서는 10, 20, 30만 있다고 가정하고 IN 연산자를 사용
SELECT *
	FROM emp
	WHERE deptno IN (20, 30) AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD')
	;
-- [예제5]
-- emp 테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하는 직원의 정보를 조회하세요.
SELECT *
	FROM emp
	WHERE job = 'SALESMAN' OR empno LIKE '78%' -- 묵시적 형변환 (무조건 바꾼다)
	;
-- [예제6]
-- emp 테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하는 직원의 정보를 조회하세요
-- LIKE 연산자를 사용금지
SELECT *
	FROM emp
	WHERE JOB = 'SALESMAN' 
	OR (empno >= 7800 AND empno < 7900)
	OR (empno >= 780 AND empno < 790)
	OR empno = 78
	;
	



-- SQL 작성순서(꼭 그렇지는 않다)			ORACLE에서 실행하는 순서
-- 1. SELECT 				3순위
-- 2. FROM					1순위
-- 3. WHERE 				2순위
-- 4. ORDER BY 				4순위

/*
 * 1. FROM
 * 2. ON
 * 3. JOIN
 * 4. WHERE
 * 5. GROUP BY
 * 6. CUBE | ROLLUP
 * 7. HAVING
 * 8. SELECT
 * 9. DISTINCT
 * 10. ORDER BY
 * 11. TOP
 */

-- 정렬
-- 정렬 방법 : ORDER BY 절을 통해 장렬 기준 컬럼을 명시
-- 		   : 컬럼 뒤에 [ASC | DESC] 를 기술하여 오름차순, 내림차순을 지정할 수 있다.

-- 1. ORDER BY 컬럼
-- 2. ORDER BY 별칭
-- 3. ORDER BY SELECT 절에 나열된 컬럼의 인덱스 번호

SELECT *
  FROM emp
 ORDER BY 컬럼 | 별칭 | 나열된 컬럼의 인덱스 번호[ASC | DESC];
 
SELECT *
  FROM emp
 ORDER BY ename DESC 
 
SELECT *
  FROM emp 
 ORDER BY deptno DESC, empno; -- empno(두번째 기준)는 두번째 기술 조건으로 같은 순위가 있을 때 조건을 줄 수 있다.
 
 -- 별칭으로 ORDER BY
 
SELECT empno, ename, sal, sal*12 salary
  FROM emp
 ORDER BY salary
;

-- SELECT 절에 기술된 컬럼순서(인덱스)로 정렬

SELECT empno, ename, sal, sal*12 salary
  FROM emp
 ORDER BY 4 -- 4번째 컬럼인 sal*12 salary로 정렬됨. ==> 데이터 추가시 다른 데이터 추출
;

SELECT *
  FROM dept
;

-- dept 테이블의 모든 정보를 부서이름으로 오름차순 정렬로 조회되도록 쿼리를 작성하세요.
SELECT *
  FROM dept
 ORDER BY DNAME 
;
-- dept 테이블의 모든 정보를 부서위치로 내림차순 정렬로 조회되도록 쿼리를 작성하세요.
SELECT *
  FROM dept
 ORDER BY loc DESC
;


SELECT *
  FROM emp
;

-- emp 테이블에서 상여(comm) 정보가 있는 사람들만 조회하고, 상여(comm)를 많이 받는 사람이 먼저 조회되도록 하고,
-- 상여가 같을 경우 사번으로 내림차순 정렬 하세요.(상여가 0인 사람은 상여가 없는 것으로 간주)

SELECT *
  FROM emp
 WHERE comm > 0 
 ORDER BY comm DESC, empno DESC 
;

-- emp 테이블에서 부서번호가 10, 30에 속하고, sal 컬럼 값이 1500 이상인 사원들을 사원명의 내림차순으로 정렬하여 조회하세요.

SELECT *
  FROM emp
 WHERE deptno IN (10, 30)
 AND sal >= 1500
 ORDER BY ename DESC 
;



