JOIN : 컬럼을 확장하는 방법(데이터 연결한다)
	   다른 테이블의 컬럼을 가져온다.
REDBMS가 중복을 최소화하는 구조이기 때문에 하나의 테이블에 데이터를 전부 담지 않고, 목적에 맞게 설계한 테이블에
데이터가 분산된다. 하지만 데이터를 조회할 때 다른 테이블의 데이터를 연결하여 컬럼을 가져올 수 있다.

ANSI-SQL : American NATIONAL Standard Institute SQL
ORACLE-SQL 문법
두개의 차이가 다소 발생 ==> 회사마다 사용하는게 다름

ANSI-SQL JOIN
NATURAL JOIN : 조인하고자 하는 테이블간 컬럼명이 동일할 경우 해당 컬럼으로 행을 연결
			   컬럼 이름 뿐만 아니라 데이터 타입도 동일해야함
문법 : 
SELECT 컬럼...
  FROM 테이블1 NATURAL JOIN 테이블2...

emp, dept 두 테이블의 공통된 이름을 갖는 컬럼 : deptno

SELECT empno, ename, deptno, dname
 FROM emp NATURAL JOIN dept
;  ==> JOIN 조건으로 사용한 컬럼은 테이블 한정자를 붙이면 에러(ANSI-SQL)

위의 쿼리를 ORACLE-SQL 버전으로 수정
오라클에서는 조인 조건을 WHERE절에 기술
행을 제한하는 조건, 조인 조건 ==> WHERE 절에 기술

SELECT emp.*, dept.deptno, dname 
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
SELECT a.*, a.deptno, dname
  FROM emp a, dept b
 WHERE a.deptno = b.deptno;
 
ANSI-SQL : JOIN WITH USING 
조인 테이블 간 동일한 이름의 컬럼이 복수개인데 이름이 같은 컬럼중 일부로만 조인하고 싶을 때 사용

SELECT *
  FROM emp JOIN dept USING (deptno);
  
위의 쿼리를 ORACLE 조인으로 변경하면?

SELECT *
  FROM emp, dept 
 WHERE emp.deptno = dept.deptno;
 
ANSI-SQL : JOIN WITH ON 
위에서 배운 NATURAL JOIN, JOIN WITH USING 의 경우에는 조인테이블의 조인컬럼이 이름이 같아야 한다는 제약조건이 있음
설계상 두 테이블의 컬럼 이름이 다를 수도 있음. 컬럼 이름이 다를경우 개발자가 직접 조인조건을 기술할 수 있도록 제공해주는 문법

SELECT *
  FROM emp JOIN dept ON (emp.deptno = dept.deptno);
  
ORACLE=SQL

SELECT *
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;