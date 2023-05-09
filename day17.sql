select min(decode(d, 1, dt, NULL)) sun, min(decode(d, 2, dt, NULL)) mon , 
	   min(decode(d, 3, dt, NULL)) tue, min(decode(d, 4, dt, NULL)) wed ,min(decode(d, 5, dt, NULL)) thu 
	 , min(decode(d, 6, dt, NULL)) fri, min(decode(d, 7, dt, NULL)) sat
FROM (
		SELECT 
				to_date(:yyyymm,'YYYYMM') + (LEVEL - 1) dt
				,to_char(to_date(:yyyymm,'YYYYMM') + (LEVEL - 1), 'D') d
				,to_char(to_date(:yyyymm,'YYYYMM') + (LEVEL - 1), 'WW') ww
		  FROM dual  
		 CONNECT BY LEVEL <= to_char(last_day(to_date(:yyyymm, 'YYYYMM')), 'DD')
		 )
 GROUP BY ww
 ORDER BY ww
;

SELECT to_date(:yyyymmdd1, 'YYYYMMDD') - to_date(:yyyymmdd2, 'YYYYMMDD') d 
  FROM dual;

SELECT 
	   MIN(DECODE(d, 1, dt, NULL)) sun, MIN(DECODE(d, 2, dt, NULL)) mon,
	   MIN(DECODE(d, 3, dt, NULL)) tue, MIN(DECODE(d, 4, dt, NULL)) wed,
	   MIN(DECODE(d, 5, dt, NULL)) thu, MIN(DECODE(d, 6, dt, NULL)) fri,
	   MIN(DECODE(d, 7, dt, NULL)) sat
  FROM (
  			SELECT DECODE(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D'), 1, TO_DATE(:yyyymm, 'YYYYMM'), NEXT_DAY(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM') - 1) - 7, 1)) + (LEVEL - 1) dt,
				   TO_CHAR(DECODE(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D'), 1, TO_DATE(:yyyymm, 'YYYYMM'), NEXT_DAY(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM') - 1) - 7, 1)) + (LEVEL - 1), 'D') d,
				   TO_CHAR(DECODE(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D'), 1, TO_DATE(:yyyymm, 'YYYYMM'), NEXT_DAY(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM') - 1) - 7, 1)) + (LEVEL - 1), 'IW') iw
			  FROM dual
			CONNECT BY LEVEL <= DECODE(TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D'), 7, LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), NEXT_DAY(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 7))
							  - DECODE(TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D'), 1, TO_DATE(:yyyymm, 'YYYYMM'), NEXT_DAY(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM') - 1) - 7, 1)) + 1
  		) calendar
 GROUP BY DECODE(d, 1, decode(iw, 52, 1, 53, 1, iw + 1), iw)
 ORDER BY sat
;

---------------------------------------------------------------------------------------------------------------------------------------------------
계층쿼리의 SELECT 퀴리의 실행순서 FROM -> START WITH, CONNECT BY -> WHERE 
일반쿼리의 SELECT 퀴리의 실행순서 FROM -> WHERE -> SELECT -> (GROUP BY) -> ORDER BY

계층쿼리에서 조회할 행의 조건을 기술할 수 있는 부분이 2곳 존재
1. WHERE - START WITH, CONNECT BY 에 의해 조회된 행을 대상으로 적용
2. CONNECT BY - 다음 행으로 연결할지, 말지를 결정

SELECT lpad(' ', (LEVEL - 1) * 4) || deptnm deptnm
  FROM dept_h
 START WITH deptcd = 'dept0'
 CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부'
;

SELECT lpad(' ', (LEVEL - 1) * 4) || deptnm deptnm
  FROM dept_h
 WHERE deptnm != '정보기획부'
 START WITH deptcd = 'dept0'
 CONNECT BY PRIOR deptcd = p_deptcd
;

--------------------------------------------------------------------------------------------------------------

[ 계층쿼리에서 사용할 수 있는 특수함수 ]

CONNECT_BY_ROOT(col) - 최상위 행의 'col' 컬럼의 값
SYS_CONNECT_BY_PATH(col, 구분자) - 계층의 순회경로를 표현(각 계층을 지나면서 어떤 컬럼을 지나 왔는지 보여줌)
CONNECT_BY_ISLEAF - 해당 행이 LEAF 노드(1)인지 아닌지(0)를 반환(최하단 노드인지 아닌지를 구별해서 알려준다.)

SELECT deptcd, p_deptcd, lpad(' ', (LEVEL - 1) * 4) || deptnm deptnm,
		CONNECT_BY_ROOT(deptnm),
		ltrim(sys_connect_by_path(deptnm, '-'), '-'),
		CONNECT_BY_ISLEAF
  FROM dept_h
 START WITH deptcd = 'dept0'
 CONNECT BY PRIOR deptcd = p_deptcd
;

SELECT seq, lpad(' ', (LEVEL - 1)* 4) || title title
  FROM board_test
 START WITH parent_seq IS NULL
 CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;
 
select *
  FROM board_test;
--------------------------------------------------------------
 ALTER TABLE board_test ADD (gn NUMBER);

UPDATE board_test SET gn = 4
WHERE seq IN (4, 5, 6, 7, 8, 10, 11);

UPDATE board_test SET gn = 1
WHERE seq IN (1, 9);

UPDATE board_test SET gn = 2
WHERE seq IN (2, 3);

select *
  FROM board_test;
  
SELECT seq, gn, parent_seq, lpad(' ', (LEVEL - 1)* 4) || title title
  FROM board_test
 START WITH parent_seq = 4
 CONNECT BY PRIOR parent_seq = seq;