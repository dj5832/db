SELF-JOIN : 동일한 테이블끼리 조인할 때 지칭하는 명칭(별도의 키워드가 아니다)

SELECT 사원번호, 사원이름, 사원의 상사 사원번호, 사원의 상사이름
  FROM emp;
  
SELECT a.empno, a.ename, a.mgr, b.ename
  FROM emp a, emp b
 WHERE a.mgr = b.empno;
 
-- KING의 경우에 상사가 없어서 13건만 조회됨.

SELECT e.empno, e.ename, e.mgr, m.ename
  FROM emp e JOIN emp m ON e.mgr = m.empno;
  
-- 사원중 사원의 번호가 7369 ~ 7698인 사원만 대상으로 사원의 사원번호, 이름, 상사의 사원번호, 상사의 이름조회
SELECT e.empno, e.ename, e.mgr, m.ename
  FROM emp e JOIN emp m ON (e.mgr = m.empno) 
 WHERE e.empno BETWEEN 7369 AND 7698;
 
SELECT e.empno, e.ename, e.mgr, m.ename
  FROM emp e, emp m
 WHERE e.mgr = m.empno 
 AND e.empno BETWEEN 7369 AND 7698;
 
NON-EQUI-JOIN : 조인 조건이 = 이 아닌 조인

SELECT *
  FROM salgrade;
  
SELECT empno, ename, sal, salgrade.grade
  FROM emp, salgrade
 WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal; 
--실습 0
SELECT empno, ename, emp.deptno, dept.dname
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;
--실습 1
SELECT e.empno, ename, e.deptno, d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno 
 AND e.deptno IN(10, 30);
 
--실습2
SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno 
 AND e.sal > 2800;
------------------------------------------------------------
SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno
 AND e.sal > 2800
 AND e.empno > 7600;
------------------------------------------------------------
SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno
 AND sal = 3000;
------------------------------------------------------------

SELECT l.lprod_gu, l.lprod_nm, p.prod_id, p.prod_name
  FROM prod p, lprod l
 WHERE p.prod_lgu = l.lprod_gu;
------------------------------------------------------------
SELECT buyer_id, buyer_name, prod_id, prod_name
  FROM buyer b, prod p
 WHERE b.buyer_id = p.prod_buyer;
----------------------------------------------------------- 
select mem_id, mem_name, prod_id, prod_name, cart_qty
  FROM MEMBER m, cart c, prod p
 where p.prod_id = c.cart_prod
 AND m.mem_id = c.cart_member;
------------------------------------------------------------
select cu.cid, cu.cnm, c.pid, c.DAY, c.cnt
  FROM customer cu,CYCLE c
 where cu.cid = c.cid
 AND cu.cid IN (1, 2);
------------------------------------------------------------
select c.cid, cu.cnm, c.pid, p.pnm, c.DAY, c.cnt
  FROM CYCLE c, product p, customer cu
 where c.pid = p.pid
 AND c.cid = cu.cid 
 AND cu.cid IN (1, 2);
-------------------------------------------------------------
select cu.cid, cu.cnm, c.pid, p.pnm, sum(cnt) 
  FROM customer cu, CYCLE c, product p
 where cu.cid = c.cid
 AND c.pid = p.pid
 GROUP BY cu.cnm, cu.cid, c.pid, p.pnm;
------------------------------------------------------------- 
select c.pid, p.pnm, sum(cnt) 
  FROM CYCLE c, product p
 where c.pid = p.pid
 GROUP BY c.pid, p.pnm;
-------------------------------------------------------------
