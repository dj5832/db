--
-- Copyright (c) Oracle Corporation 1988, 1999.  All Rights Reserved.
--
--  NAME
--    demobld.sql
--
-- DESCRIPTION
--   This script creates the SQL*Plus demonstration tables in the
--   current schema.  It should be STARTed by each user wishing to
--   access the tables.  To remove the tables use the demodrop.sql
--   script.
--
--  USAGE
--       SQL> START demobld.sql
--
--

CREATE TABLE BONUS
        (ENAME VARCHAR2(10),
         JOB   VARCHAR2(9),
         SAL   NUMBER,
         COMM  NUMBER);

CREATE TABLE EMP
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7, 2),
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2));


INSERT INTO EMP VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        TO_DATE('17-DEC-1980', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),  800, NULL, 20);
INSERT INTO EMP VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        TO_DATE('20-FEB-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 1600,  300, 30);
INSERT INTO EMP VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        TO_DATE('22-FEB-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 1250,  500, 30);
INSERT INTO EMP VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        TO_DATE('2-APR-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),  2975, NULL, 20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        TO_DATE('28-SEP-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 1250, 1400, 30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        TO_DATE('1-MAY-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),  2850, NULL, 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        TO_DATE('9-JUN-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),  2450, NULL, 10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        TO_DATE('09-DEC-1982', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 3000, NULL, 20);
INSERT INTO EMP VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        TO_DATE('17-NOV-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 5000, NULL, 10);
INSERT INTO EMP VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        TO_DATE('8-SEP-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),  1500, 0, 30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        TO_DATE('12-JAN-1983', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 1100, NULL, 20);
INSERT INTO EMP VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),   950, NULL, 30);
INSERT INTO EMP VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),  3000, NULL, 20);
INSERT INTO EMP VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        TO_DATE('23-JAN-1982', 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'), 1300, NULL, 10);

CREATE TABLE DEPT
       (DEPTNO NUMBER(2),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE SALGRADE
        (GRADE NUMBER,
         LOSAL NUMBER,
         HISAL NUMBER);

INSERT INTO SALGRADE VALUES (1,  700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

COMMIT;

-- expressoin : 컬럼값을 가공을 하거나, 존재하지 않는 새로운 상수값(정해진 값)을 표현
--				연산을 통해 새로운 컬럼을 조회할 수 있다.
--				연산을 하더라도 해당 SQL 조회 결과에만 나올 뿐이고 실제 테이블의 데이터에는 영향을 주지 않는다.
--				SELECT 구문은 데이터의 정보에 영향을 주지 않음.
SELECT sal, sal+500, sal-500, sal/5, 500
	FROM  emp; 
	
SELECT * 
	FROM dept;
	
-- 날짜에 사칙연산 : 수학적으로 정의가 되어있지 않음
-- SQL 에서는 날짜데이터 +- 정수 ==> 정수를 일자 취급

--'2023년 4월 13일' + 5 : 2023년 4월 13일 부터 5일 지난 날짜
--'2023년 4월 13일' - 5 : 2023년 4월 13일 부터 5일 이전 날짜

--데이터베이스에서 주로 사용하는 데이터 타입 : 문자, 숫자, 날짜

--DESC emp;  --> sqlplus

/*
empno : 숫자
ename : 문자
job : 문자
mgr : 숫자
hiredate : 날짜
sal : 숫자
comm : 숫자
deptno : 숫자
*/

SELECT hiredate, hiredate + 5, hiredate - 5
	FROM emp;
	
-- users 테이블의 컬럼 타입을 확인하고, reg_df 컬럼 값에 5일 뒤 날짜를 새로운 컬럼으로 표현
-- 조회 컬럼 : userid, reg_dt, reg_dt 5일 뒤 날짜

SELECT userid, reg_dt, reg_dt + 5
	FROM users;

/*
 * NULL : 아직 모르는 값, 할당되지 않은 값
 * NULL과 숫자타입의 0은 다르다
 * NULL과 문자타입의 공백은 다르다
 * 필요한 경우 NULL값을 다른값으로 치환
 * 
 * NULL의 중요한 특징
 * NULL을 피연산자로 하는 연산의 결과는 항상 NULL
 * ex) NULL + 500 ==> NULL*/


-- emp 테이블에서 sal 컬럼과 comm 컬럼의 합을 새로운 컬럼으로 표현
-- 조회 컬럼은 empno. ename, sal, comm, sal 컬럼과 comm 컬럼의 합

SELECT empno, ename, comm, sal, sal + comm
	FROM emp;
	
-- ALIAS : 컬럼이나, expression에 새로운 이름을 부여
-- 적용 방법 : 컬럼, expression [AS] 별칭명
SELECT empno AS 사번, ename NAME, sal AS 급여, comm 커미션, sal + comm sal_plus_comm
	FROM emp;
	
