-- select : 조회할 때 사용
-- select <컬럼이름> from <테이블 이름>
-- 한 줄 드래그하고 ctrl + enter
select ename from emp

-- 사원이름, 번호 조회
-- 1개 이상 컬럼을 조회할 때는 ,(콤마) 사용
select ename, empno from emp

-- 사원번호, 사원이름, 직책 조회
select ename, empno, job from emp

-- as(별칭) 임시적
select ename as '사원이름', empno as '사원번호' from emp
select * from emp

-- where (필터링)
-- 20번 부서 사원 모두 조회
-- 쿼리 순서 : 1. from 2. where 3. select
select * from emp where deptno = 20

-- 문제 1. job이 manager인 사원이름, 사원번호, 직책, 입사날짜 조회하시오.
select ENAME, EMPNO, JOB, HIREDATE from emp where job = 'manager'

-- 문제 2. job이 manager, salesman인 사원번호, 사원이름 조회 
select ENAME, EMPNO from emp where job = 'manager' or job = 'salesman'

-- 문제 3. 사원이름이 ALLEN인 사원의 이름, 직책, 입사날짜 조회
select ENAME, JOB, HIREDATE from emp where ename = 'allen'

-- 사원이름이 A로 시작하는 사원의 이름, 사원번호 조회
select ENAME, EMPNO from emp where ename like 'A%'

-- 사원 이름에 L이 두번 들어간 사원 이름, 번호 조회
select ENAME, EMPNO from emp where ename like '%L%L%'

-- 보너스를 받지 못한 사원의 급여와 번호를 조회
select sal, EMPNO from emp where comm is null
select sal, EMPNO from emp where comm is not null

-- 입사날짜가 1987-06-28 이상인 사원 이름, 번호, 직책 조회
select ename, empno, job,hiredate from emp where hiredate >= '1987-06-28'

-- 문제 4. 입사일이 1980-12-17 ~ 1982-01-23 사이에 입사한 사원의 이름, 번호, 입사날짜, 직책을 조회하시오.
select ename, EMPNO, HIREDATE , JOB from emp where HIREDATE >= '1980-12-17' and HIREDATE <= '1982-01-23'

-- 문제 5. 직업이 manager고, 급여가 1300이상 받는 사원번호, 이름, 급여, 직업 조회
select ENAME, EMPNO, SAL, JOB from emp where job = 'manager' and sal >= 1300

-- avg, count, max, min 함수 (단일행 함수)
-- 직업이 manager인 사원들의 급여 평균 조회
select avg(sal) as '급여 평균', job from emp where job = 'manager'

-- 직업이 clerk인 사원 수 조회
select count(ename) as '사원수' from emp where job = 'clerk'
select max(sal) from emp where job = 'clerk'
select min(sal) from emp where job = 'clerk'

-- 문제 6. 입사날짜가 '1987-06-28' 이상인 사원들의 수와 급여 평균 조회
select count(ename), avg(sal) from emp where HIREDATE >= '1987-06-28'

-- 문제 7. 직책이 'manager'가 아닌 사원이름, 직책 조회
select ename, job from emp where job != 'manager'

-- 문제 8. 사원 이름이 'scott', 'jones'인 사원의 이름, 번호, 급여, 입사날짜 조회
-- 방법 1
select ENAME, EMPNO, sal, HIREDATE from emp where ENAME = 'scott' or ENAME = 'jones'
-- 방법 2
select ENAME, EMPNO, sal, HIREDATE from emp where ENAME in('scott','jones')

-- -----------------------------------------------------------------------------------------------------------------------------------
-- group by : 특정 컬럼을 그룹핑 하는 SQL 문법
-- job 별로 group by 하기
-- group by 할 컬럼을 select에도 써주자!
select job as '직책 그룹핑' from emp group by job

-- 입사날짜로 group by
select HIREDATE from emp group by HIREDATE 

-- 입사날짜를 년도 별로 group by
-- date_format() SQL 내장 함수, 날짜를 원하는대로 포맷팅 해줌.
-- %Y : year (년도), %M : month (월), %D : day (일)
select date_format(hiredate,'%Y') as '입사년도', count(empno) as '사원 수' from emp group by date_format(HIREDATE, '%Y')

-- 문제 1. 부서별로 그룹핑하고 부서인원 수도 출력하시오.
select deptno, count(empno) from emp group by deptno

-- 20번 부서를 제외한 나머지 부서 그룹핑!
select deptno from emp where deptno != 20 group by DEPTNO

-- having : group by된 결과를 필터링할 때 사용
-- where : 필터링
-- where 조건 안쓰고 having으로 사용하기
-- having과 where 차이점
-- 1. SQL 실행 순서가 다르다.
-- 2. where 조건에 집계함수(count, max, min, avg ..)으로 비교 불가능
-- 3. having은 집계함수 비교 가능
select sal from emp having sal>2000
select DEPTNO as '부서 번호', count(EMPNO) as '사원 수' from emp group by DEPTNO having count(empno) >= 4

-- group by된 결과를 필터링하고 싶을 때 사용
-- 문제2. 부서별로 급여합계를 그룹핑 하시오. (hint : sum)
select sum(sal) from emp group by DEPTNO

-- 문제3. 문제 2번에서 급여합계가 5000 이상인 부서만 조회
select sum(sal) from emp group by DEPTNO having sum(sal) >=5000

-- 문제4. 문제 3번에서 10번 30번 부서 제외
select sum(sal) from emp where DEPTNO = 20 group by DEPTNO having sum(sal) >=5000

-- 문제 5. 입사날짜를 월별로 그룹핑하고 월별 입사자를 출력하시오.
select date_format(HIREDATE, '%M'), count(ename) from emp group by date_format(HIREDATE, '%M')

-- 문제 6. 직책별로 그룹핑하고 평균 급여를 조회하고, 평균 급여가 1000이 넘는 직팩만 출력하시오. 단) 직책이 manager는 제외
select avg(sal), job from emp where job != 'manager' group by job having avg(sal) >= 1000

-- 문제 7. 1982년도에 입사한 모든 사원의 정보 조회
select * from emp where date_format(HIREDATE, '%Y') = '1982'

-- 문제 8. 급여가 1500 ~ 2850 사이의 범위에 속하는 사원 이름, 급여, 직책 조회
select ENAME, SAL, JOB from emp where sal >= 1500 and sal <= 2850

-- order by : 특징 컬럼을 정렬할 때 사용 (항상 마지막에 실행 됨)
-- 아래 쿼리는 오름차순
select ename, sal from emp order by sal
-- 아래 쿼리는 내림차순
select ename, sal from emp order by sal desc
-- 컬럼 위치로 정렬하기
select ename, sal from emp order by 2

-- 총 정리
select deptno, count(empno), sum(sal), avg(sal) from emp where deptno != 10 group by deptno having count(empno) >= 3 order by count(empno) desc

## delete, update, insert
-- delete (데이터 삭제)
-- 삭제할 때는 where 조건으로 삭제하자
delete from emp
-- truncate 테이블 안에 있는 데이터를 초기화
truncate table emp

-- commit(완전 저장), rollback(이전 상태로 돌아가기)
-- auto commit을 해제 하면 rollback(뒤 돌아가기)으로 돌아갈 수 있음
-- auto commit 설정되어 있으면 rollback 명령어 불가능!
rollback

-- join****
-- 관계형 데이터베이스(MySQL, Oracle, Tibero ...)
-- 를 사용하면 join은 무조건 사용한다.
-- depno : 부서번호, dname : 부서이름, loc : 부서위치
-- 조인은 컬럼 이름이 같다고 해서 되는게 아니라, 데이터 타입이 서로 같아야 한다. 
-- 컬럼 이름이 같은 이유는 사용자(개발자) 편의성을 위해서 같게 해준다.

-- join 문법 
-- 테이블 이름에도 as를 사용할 수 있다. 
-- 방법 1.
select e.ename,e.deptno,d.dname from emp as e inner join dept as d on e.deptno = d.deptno

-- 방법 2. (추천 x)
-- where 조건으로도 사용할 수 있지만
-- where가 나온 목적은 연산자(비교)를 이용해서 필터링을 하는게 목적이다.
-- 때문에 아래 방법보다는 방법 1로 join을 사용하자.
select e.ename,e.deptno,d.dname from emp as e, dept as d where e.deptno = d.deptno

-- 사원번호가 7788인 사원의 이름,직책,부서번호,부서이름,근무지역을 조회하시오.
-- 조인 팁 : 두 테이블 교집합 컬럼을 찾자!
select e.ename, e.job, e.deptno, d.dname, d.loc from emp as e inner join dept as d on e.deptno = d.deptno where e.empno = 7788

-- 부서별로 그룹핑을 하고 부서번호와 (부서이름)을 조회하시오.
-- join 문법은 from과 where 사이에 온다.
select e.deptno, d.dname from emp as e inner join dept as d on e.deptno = d.deptno group by e.deptno

-- 직책이 manager인 사원들의 이름, 부서이름, 부서위치를 조회하시오.
select e.ename as "사원 이름", d.dname as "부서 번호", d.loc as "부서 위치" from emp as e inner join dept as d on e.deptno = d.deptno where e.job = 'manager'

-- inner join(교집합)에서 순서는 상관없지만
-- right join과 left join은 상관 있다.
select * from dept as d inner join emp as e

-- left join(차집합), right join(차집합) : 아우터(outer) 조인
-- 40번 부서만 조회
select * from dept where deptno = 40;

-- emp테이블에 없는 부서번호 조회
select * from dept as d left join emp as e on d.deptno = e.deptno where e.empno is null

-- self join (inner join하고 같음)
-- 그러나 자기 자신을 조인함 즉, 1개 테이블을 사용
-- boss: 상사 ,underling: 부하
select boss.empno as '상사 번호',boss.ename as '상사 이름',underling.empno as '부하직원 번호',underling.ename as '부하직원 이름' from emp as boss inner join emp as underling on boss.empno = underling.mgr

-- emp에 insert 하기
insert into emp (empno, ename, job, sal, hiredate) values (8000, '손흥민', 'SALESMAN', 7000, now());

-- 문제. 아우터 조인(left or right) 이용하기
-- 부서에 소속되어 있지 않는 사원 번호,이름,입사날짜 조회
-- 결과 흥민 손! 쏘니!
select * from emp as e left join dept as d on e.deptno = d.deptno where d.dname is null

-- 사원번호가 8000인 사원의 급여를 8000으로 업데이트 하시오
-- update는 from을 명시하지 않는다.
-- delete from을 써준다.
update emp set sal = 8000 where empno = 8000

-- join 
select * from emp as e inner join dept as d on e.deptno = d.deptno
-- outer join
select * from emp as e right join dept as d on e.deptno = d.deptno where e.empno is null
-- self join
-- junior: 사원, senior: 사수
select 
	junior.empno as "부하 번호",
	junior.ename as "부하 이름",
	senior.empno as "사수 번호",
	senior.ename as "사수 이름"
from emp as junior
inner join emp as senior on junior.mgr = senior.empno

-- SQL 순서
-- 1. from 2. where 3. group by 4. having 5. select 
-- 6. order by

-- delete from emp
-- update emp

-- null 하고 문자 'null' 하고는 다른거!
-- is null, is not null

-- PK는 중복허용 X (auto index)
-- FK는 중복이 가능함 (index 없음)
insert into dept (deptno, dname, loc)
values (20, 'DW아카데미', '대전 선화동')
-- 위 SQL은 dept 테이블에 20번 부서가 이미 있으므로 에러 발생!

-- tip) 자주 조회하는 컬럼 일수록 위에다 정의를 해야함

select 
	junior.ename, 
	senior.ename, 
	d.deptno, 
	d.dname, 
	d.loc 
from emp as junior 
inner join emp as senior 
right join dept as d 
on junior.mgr = senior.empno and junior.DEPTNO  = d.DEPTNO

SELECT
			empno,
			ename,
			job,
			date_format(HIREDATE, '%Y')
		FROM emp
		WHERE sal >= 2000
		
select 
	e.empno,
	e.ename,
	d.dname
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 

select now()

-- 전체사원의 사원번호, 사원이름, 부서번호을 모두 출력하시오.

select
	e.empno,
	e.ename,
	d.dname
from emp as e
inner join dept as d 
on e.deptno = d.deptno

select
			empno,
			ename,
			sal,
			hiredate,
			job,
			deptno
		from emp
-- 사원수 조회 하는 쿼리 작성하시오!
select count(EMPNO) from emp 
-- 평균 급여 조회 쿼리
select avg(sal) from emp 
-- 부서 수 조회 쿼리
select count(deptno) from dept
-- 보너스합 조회 쿼리		
select sum(comm) from emp
		
-- 서브 쿼리 (메인쿼리 안에 서브쿼리가 옴)
select 
	count(EMPNO) as 'empCount',
	(select round(avg(sal)) from emp) as 'empSalAvg',
	(select count(deptno) from dept) as 'deptCount',
	(select round(sum(comm)) from emp) as 'empCommSum'
from emp
-- 쿼리작성하기
select 
	e.empno,
	e.ename,
	e.JOB,
	e.sal,
	e.HIREDATE,
	d.dname
from emp as e
inner join dept as d
on e.DEPTNO = d.DEPTNO 

	update emp 
	set 
		ename = '이강인',
		job = 'MANAGER'
	where empno = 200;	

alter table emp add column is_use bool

-- DML : SELECT, INSERT, update, delete (not-auto commit)
-- DDL : alter, drop, create (auto commit)
update emp 
set is_use = true 

select count(*) from emp where is_use = true;

ALTER TABLE dept ADD COLUMN is_use BOOL
UPDATE dept SET is_use = TRUE;

-- 부모테이블 delete(참조키제공)
DELETE FROM dept 
WHERE deptno = 30

-- 부모테이블에 데이터를 삭제하고 싶으면 CASCADE 설정을 해야 한다.

-- 자식테이블 DELETE (참조키사용)
DELETE FROM emp
WHERE deptno = 30

		
CREATE TABLE A (
	idx int(4)  NOT NULL PRIMARY KEY COMMENT 'PK 아이디',
	create_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT '생성 날짜'
)

CREATE TABLE B (
	b_idx int(4)  NOT NULL PRIMARY KEY COMMENT 'B테이블 PK',
	a_idx int(4) COMMENT 'A테이블 FK',
	FOREIGN KEY(a_idx) REFERENCES A(idx) ON DELETE CASCADE
)

INSERT INTO a (idx) VALUES (1); 
INSERT INTO a (idx) VALUES (2); 
INSERT INTO a (idx) VALUES (3); 
INSERT INTO a (idx) VALUES (4); 
-- 1~4 숫자만 참조키이니까
INSERT INTO b (b_idx, a_idx) VALUES (1, 3)
INSERT INTO b (b_idx, a_idx) VALUES (2, 3)

DELETE FROM a 
WHERE idx = 3;

-- ON DELETE CASCADE : 부모테이블에 데이터를 지우면,
-- 참조하고 있는 자식테이블 데이터도 모두 지워진다.

-- ON DELETE SET NULL : 부모테이블에 데이터를 지우면,
-- 참조하고 있는 자식테이블에 컬럼이 NULL로 변경된다.

-- ON DELETE RESTRICT(default) : 부모테이블에 데이터를 지울때,
-- 자식테이블에서 데이터를 참조하고 있다면 삭제, 변경 불가능

-- ON DELETE NO ACTION : 부모테이블에서 데이터를 지우면, 
-- 자식테이블에 아무런 영향을 받지 않는다.

-- ON DELETE SET DEFAULT : 부모테이블에서 데이터를 지울때,
-- 참조하고 있는 자식테이블 컬럼이 DEFAULT 값으로 변경된다. 

-- 부서 목록 삭제 : 구글링을 해서 EMP테이블 ON DELETE 설정 추가하는 법 검색해서 적용하기
-- ON DELETE는 관계형 데이터베이스만 존재(Mysql, Oracle, MariaDB ...)

--- 로그 테이블 생성하기
-- AUTO_INCREMENT 자동으로 값이 1씩 증가
CREATE TABLE emp_logs(
	log_id bigint(20) AUTO_INCREMENT PRIMARY KEY COMMENT '로그번호' ,
	ip varchar(50) COMMENT '사용자 아이피',
	url varchar(100) COMMENT '접속경로',
	http_method VARCHAR(10) COMMENT 'http method',
	create_at DATETIME COMMENT '접속 시간'
)
CREATE TABLE IF NOT EXISTS DEPT (
    DEPTNO DECIMAL(2),
    DNAME VARCHAR(14),
    LOC VARCHAR(13),
    CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO) 
);

CREATE TABLE IF NOT EXISTS EMP (
    EMPNO DECIMAL(4),
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    MGR DECIMAL(4),
    HIREDATE DATE,
    SAL DECIMAL(7,2),
    COMM DECIMAL(7,2),
    DEPTNO DECIMAL(2),
    IS_USE tinyint(1) DEFAULT true,
    CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
    CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20,true);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30,true);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-2-1981','%d-%m-%Y'),1250,500,30,true);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20,true);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30,true);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30,true);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10,true);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,STR_TO_DATE('13-7-1987','%d-%m-%Y')-85,3000,NULL,20,true);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,STR_TO_DATE('17-11-1981','%d-%m-%Y'),5000,NULL,10,true);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,STR_TO_DATE('8-9-1981','%d-%m-%Y'),1500,0,30,true);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,STR_TO_DATE('13-7-1987', '%d-%m-%Y'),1100,NULL,20,true);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,STR_TO_DATE('3-12-1981','%d-%m-%Y'),950,NULL,30,true);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,STR_TO_DATE('3-12-1981','%d-%m-%Y'),3000,NULL,20,true);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,STR_TO_DATE('23-1-1982','%d-%m-%Y'),1300,NULL,10,true);
COMMIT;

-- insert 컬럼이름을 명시하는 문법  


-- ex) INSERT into emp (empno) VALUES(2000)
-- 컬럼이름을 명시하는 INSERT는 다른 컬럼들 생략가능
-- 단, 다른 컬럼들이 NOT NULL이라면 그 컬럼은 넣어야 함.

-- insert 컬럼이름 생략 문법
-- INSERT INTO emp VALUES(2000)
-- 해당 테이블 데이터 모두 입력해야함.
INSERT INTO emp VALUES (3000,10)

INSERT INTO emp_logs(create_at) VALUES(now())

	SELECT
		log_id AS logID,
		ip,
		url,
		http_method AS httpMethod,
		create_at AS createAt
	FROM  emp_logs	
		
-- 드론 테이블
CREATE TABLE IF NOT EXISTS drone (
    uuid VARCHAR(20) PRIMARY KEY COMMENT '드론 고유아이디',
    model_name VARCHAR(30) NOT NULL COMMENT '드론 모델명',
    battery DECIMAL(3,0) DEFAULT 100 COMMENT '배터리',
    loc VARCHAR(50) COMMENT '현재 위치',
    latitude VARCHAR(30) COMMENT '현재 위도',
    longitude VARCHAR(30) COMMENT '현재 경도',
    is_message BOOLEAN COMMENT '드론 통신상태 여부',
    is_use BOOLEAN COMMENT '드론 사용 여부',
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록날짜'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 드론 운행 
CREATE TABLE IF NOT EXISTS drone_driving (
    driving_no BIGINT(20) AUTO_INCREMENT PRIMARY KEY COMMENT '운행 번호',
    uuid VARCHAR(20) COMMENT '드론 고유아이디',
    start_at DATETIME COMMENT '출발 시간',
    end_at DATETIME COMMENT '도착 시간',
    driving_distance DECIMAL(4,1) COMMENT '운행 거리(KM)',
    FOREIGN KEY (uuid) REFERENCES drone (uuid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 드론 운행 상세이력
CREATE TABLE IF NOT EXISTS drone_driving_history (
    history_no BIGINT(20) AUTO_INCREMENT PRIMARY KEY COMMENT '운행 상세이력 번호',
    driving_no BIGINT(20) COMMENT '운행 번호',
    latitude VARCHAR(30) COMMENT '현재 위도',
    longitude VARCHAR(30) COMMENT '현재 경도',
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '운행 날짜',
    FOREIGN KEY (driving_no) REFERENCES drone_driving (driving_no)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 드론 데이터
insert into drone(uuid, model_name, loc, latitude, longitude, is_message, is_use) 
values(201210325, 'KAZA-556699', '대전 충정로 136', '36.3432473', '127.4487079', true, true);

insert into drone(uuid, model_name, loc, latitude, longitude, is_message, is_use) 
values(101210777, 'SAMA-931207', '대전 중앙로121번길 20', '36.3286904', '127.4229992', true, true);

insert into drone(uuid, model_name, loc, latitude, longitude, is_message, is_use) 
values(211016700, 'AJJK-200489', '대전 진잠로92번길 24', '36.2996845', '127.3169115', true, true);

-- 드론 운행정보
insert into drone_driving(uuid, start_at, end_at, driving_distance)
values(201210325, '2022-11-13 14:02:56', '2022-11-13 15:00:56', 8.5);
insert into drone_driving(uuid, start_at, end_at, driving_distance)
values(101210777, '2022-11-13 09:30:00', null, 0);

-- 드론 운행상세정보
insert into drone_driving_history(driving_no, latitude, longitude, create_at)
values(1, '36.3286904', '127.4229992', '2022-11-13 14:02:56');
insert into drone_driving_history(driving_no, latitude, longitude, create_at)
values(1, '36.3325226', '127.4338474', '2022-11-13 14:11:30');
insert into drone_driving_history(driving_no, latitude, longitude, create_at)
values(1, '36.3499999', '127.4370503', '2022-11-13 14:22:00');
insert into drone_driving_history(driving_no, latitude, longitude, create_at)
values(1, '36.3577778', '127.4063889', '2022-11-13 14:41:40');
insert into drone_driving_history(driving_no, latitude, longitude, create_at)
values(1, '36.3711638', '127.3883444', '2022-11-13 14:50:16');
insert into drone_driving_history(driving_no, latitude, longitude, create_at)
values(1, '36.4240196', '127.3958129', '2022-11-13 15:00:56');

SELECT
	uuid,
	battery,
	model_name AS modelName,
	is_message AS isMsg,
	loc,
	latitude,
	longitude,
	create_at AS createAt 
FROM drone
WHERE uuid = #{uuid}

SELECT 
	dd.driving_no  AS drivingNo,
	dd.start_at AS startAt,
	dd.end_at AS endAt
FROM drone AS d
INNER JOIN drone_driving dd  AS dd
ON d.uuid  = dd.uuid 
WHERE d.uuid = '101210777'

-- 상세 운행 기록
SELECT 
	ddh.history_no AS historyNo,
	ddh.latitude,
	ddh.longitude,
	ddh.create_at AS creatAt
FROM drone_driving AS dd
INNER JOIN drone_driving_history AS ddh 
ON dd.driving_no = ddh.driving_no 
WHERE dd.driving_no = 1;

DELETE
FROM dept
WHERE DEPTNO = 50

ALTER TABLE  emp DROP
FOREIGN KEY FK_DEPTNO;

ALTER TABLE emp ADD
CONSTRAINT FK_DEPTNO
FOREIGN KEY (DEPTNO)
REFERENCES DEPT(DEPTNO)
ON DELETE SET NULL;



SELECT
			COUNT((SELECT EMPNO WHERE IS_USE = TRUE)) AS "empCount"
FROM emp


