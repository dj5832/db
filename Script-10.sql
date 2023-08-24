SELECT *
FROM mem_sns_login;		 

ALTER TABLE TEAM_2023021F.MEM_SNS_LOGIN MODIFY ACCESS_TOKEN VARCHAR2(200);
ALTER TABLE TEAM_2023021F.MEM_SNS_LOGIN MODIFY REFRESH_TOKEN VARCHAR2(200);


SELECT m.MOVIE_NAME , r.*, mem.MEM_ID 
  FROM movie m, review r, MEMBER mem
 WHERE m.MOVIE_CD = r.MOVIE_CD
   AND mem.MEM_CD = r.MEM_CD ;
   
  SELECT count(*) reviewlike, review_no
		  		  FROM review_like
		  		GROUP BY review_no;
		  		
		  	SELECT m.MOVIE_NAME , r.*, mem.MEM_ID, (
		  		SELECT count(*)
		  		  FROM review_like
		  		 WHERE REVIEW_NO = r.REVIEW_NO
		  		) reviewlike
		  FROM movie m, review r, MEMBER mem
		 WHERE m.MOVIE_CD = r.MOVIE_CD
 		   AND mem.MEM_CD = r.MEM_CD
 		   AND r.gb_del = 'N';
 		   
 		  SELECT r.*, nvl(reviewlike, 0) reviewlike, mem_id, mem_pic_path
		FROM (
			SELECT count(*) reviewlike, review_no
			FROM review_like
			GROUP BY review_no
			)rl, review r, MEMBER m
		WHERE rl.review_no(+) = r.review_no
		AND r.mem_cd = m.mem_cd
		AND r.gb_del = 'N'
		AND rownum <= 3;
		
	
	
	
SELECT r.*, m.movie_name, mem.mem_id
  FROM review r, movie m, member mem
 WHERE movie_name like '%엘%'
   AND m.MOVIE_CD = r.MOVIE_CD
   AND mem.MEM_CD = r.MEM_CD;
   
  
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200406270048', 'TH202307120001', '10', '와우 개꿀잼!', sysdate, 'N');
	
	
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200406270048', 'HO202307050005', '10', '와우 개꿀잼!!!!', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200406270048', 'HO202307050005', '10', '와우 개꿀잼!!!!!!!', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200406270048', 'TH202307120001', '10', '와우 개꿀잼!!?!?!?!?', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M197407020003', 'AN202307200009', '10', '진실은 하나!', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M197407020003', 'AN202307200009', '10', '악마 희성', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M197407020003', 'AN202301040012', '10', '이게 무슨 영화야', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M197407020003', 'AN202301040012', '10', '와우 개꿀잠!', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200807010004', 'SF202307050016', '10', '와우 개너젬!', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200807010004', 'SF202307050016', '10', '오점뭐?', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200807010004', 'DO202307130025', '10', '눈물..', sysdate, 'N');
  INSERT INTO review (review_no, mem_cd, movie_cd, review_rating, review_content, regdate, gb_del) 
		VALUES (review_seq.nextval, 'M200807010004', 'DO202307130025', '10', '싱하형...', sysdate, 'N');
	
	
SELECT *
  FROM (
			SELECT r.MERCHANT_UID
				  ,LISTAGG(r.MEM_CAT , ', ') WITHIN GROUP(ORDER BY r.mem_cat) mem_cat
				  ,LISTAGG(r.RES_SEAT , ', ') WITHIN GROUP(ORDER BY RES_SEAT)  res_seat
				  ,MAX(startdate)
				  ,MAX(RESDATE)
				  ,MAX(h.house_name)
				  ,MAX(h.thr_name)
				  ,MAX(REFUNDDATE)
				  ,MAX(m.movie_name)
				  ,MAX(m.movie_cd)
				  ,MAX(m.MOVIE_MAINPIC_PATH)
			  FROM RESERVATION r
			  	  ,screen s
			  	  ,movie m
			  	  ,house h
			  	  ,PAY_DETAIL p
			 WHERE r.mem_cd = 'M197407020003'
			   AND s.screen_cd = r.screen_cd 
			   AND s.movie_cd = m.movie_cd
			   AND h.house_no = s.house_no
			   AND p.merchant_uid = r.merchant_uid
			 GROUP BY r.merchant_uid
			 ORDER BY r.merchant_uid
		)
 WHERE rownum <= 2
;


SELECT count(*) total_count
  FROM (
  		SELECT r.MERCHANT_UID
		  ,LISTAGG(r.MEM_CAT , ', ') WITHIN GROUP(ORDER BY r.mem_cat) mem_cat
		  ,LISTAGG(r.RES_SEAT , ', ') WITHIN GROUP(ORDER BY RES_SEAT)  res_seat
		  ,MAX(startdate)
		  ,MAX(RESDATE)
		  ,MAX(h.house_name)
		  ,MAX(h.thr_name)
		  ,MAX(REFUNDDATE)
		  ,MAX(m.movie_name)
		  ,MAX(m.movie_cd)
		  ,MAX(m.MOVIE_MAINPIC_PATH)
	  FROM RESERVATION r
	  	  ,screen s
	  	  ,movie m
	  	  ,house h
	  	  ,PAY_DETAIL p
	 WHERE r.mem_cd = 'M197407020003'
	   /*AND TO_CHAR(startdate, 'YYYYMM') LIKE '202307'*/
	   AND s.screen_cd = r.screen_cd 
	   AND s.movie_cd = m.movie_cd
	   AND h.house_no = s.house_no
	   AND p.merchant_uid = r.merchant_uid
	 GROUP BY r.merchant_uid
  	) count;
	

DELETE reservation WHERE merchant_uid LIKE 'MM%';


SELECT *
  FROM screen
 WHERE startdate like STR_TO_DATE('202307', '%Y-%m') ;
 
SELECT startdate
  FROM screen
 WHERE TO_CHAR(startdate, 'YYYYMM') LIKE '202307';
  
SELECT TO_CHAR(to_date('202307', 'YYYY-MM'), 'YYYY-MM')
  FROM dual;
  
 SELECT c.coupon_name, mc.enddate, mc.gb_use
   FROM coupon c, mem_coupon mc
  WHERE c.coupon_cd = mc.coupon_cd
    AND mc.mem_cd = 'M197407020003';
    
SELECT mb.buydate, p.product_div, p.product_name, p.product_price, mp.gb_use
  FROM mem_buy mb, product p ,mem_product mp
 WHERE mb.mem_cd = 'M197407020003';

SELECT *
  FROM (
		SELECT mb.buydate, p.product_div, p.product_name, p.product_price, mp.gb_use, pd.refunddate, mb.gb_cancel
		  FROM mem_buy mb, product p ,mem_product mp, pay_detail pd
		 WHERE mb.mem_cd = 'M197407020003'
		   AND p.product_cd = mb.product_cd
		   AND mb.merchant_uid = mp.merchant_uid
		   AND mb.merchant_uid = pd.merchant_uid
		   ORDER BY buydate desc
		   )
 WHERE rownum <= 3
;
SELECT mb.*, p.*
  FROM mem_buy mb, product p
 WHERE mb.mem_cd = 'M197407020003'
   AND p.product_cd = mb.product_cd
;

SELECT mc.*, c.*
  FROM mem_coupon mc, coupon c
 WHERE mem_cd = 'M197407020003'
   AND mc.coupon_cd = c.coupon_cd
;

SELECT *
  FROM MEMBER m, admin a
 WHERE 

SELECT admin_cd, admin_id, admin_pwd
  FROM admin

UNION
 
SELECT mem_cd, mem_id, mem_pwd
  FROM member
  ;
 
CREATE OR REPLACE VIEW accountCheck 
AS

SELECT mem_cd cd, mem_id id, mem_pwd pwd, gb_del, gb_sleep, gb_ban, mem_phone phone, mem_name name, mem_email email, 'M' auth, mem_grade grade
  FROM member

UNION
 
SELECT admin_cd, admin_id, admin_pwd, 'N', 'N', 'N', '000', '없다', 'email', substr(admin_cd,0,1), 'N'
  FROM admin
  
  SELECT *
    FROM accountCheck;
    
DROP VIEW accountCheck;

SELECT *
  FROM accountCheck;
 
 SELECT *
   FROM (
	SELECT r.MERCHANT_UID
		  ,LISTAGG(r.MEM_CAT , ', ') WITHIN GROUP(ORDER BY r.mem_cat) mem_cat
		  ,LISTAGG(r.RES_SEAT , ', ') WITHIN GROUP(ORDER BY RES_SEAT) res_seat
		  ,MAX(startdate) startdate
		  ,MAX(RESDATE) RESDATE
		  ,MAX(h.house_name) house_name
		  ,MAX(h.thr_name) thr_name
		  ,MAX(REFUNDDATE) REFUNDDATE
		  ,MAX(m.movie_name) movie_name
		  ,MAX(m.movie_cd) movie_cd
		  ,MAX(m.movie_mainpic_path) movie_mainpic_path
		  ,MAX(m.MOVIE_DIRECTOR) MOVIE_DIRECTOR
		  ,MAX(m.MOVIE_ACTOR) MOVIE_ACTOR
	  FROM RESERVATION r
	  	  ,screen s
	  	  ,movie m
	  	  ,house h
	  	  ,PAY_DETAIL p
	 WHERE r.mem_cd = 'M197407020003'
	   AND s.screen_cd = r.screen_cd 
	   AND s.movie_cd = m.movie_cd
	   AND h.house_no = s.house_no
	   AND p.merchant_uid = r.merchant_uid
	 GROUP BY r.merchant_uid
	 )
ORDER BY startdate DESC
 ;
 

SELECT *
  FROM RESERVATION;
SELECT * 
  FROM theater
 WHERE thr_loc = '광주/전라';
 
SELECT *
  FROM answer;
SELECT count(*)
  FROM (
		SELECT q.*, a.que_no, a.admin_cd, a.ans_content
		  FROM question q, answer a
		 WHERE mem_cd = 'M197407020003'
		   AND gb_del = 'N'
--		   AND que_type like '%' || '이벤트' || '%'
		   AND q.que_no = a.que_no(+)
		   ORDER BY q.regdate DESC
		   )
 ;
SELECT rownum, q.*
  FROM (
		SELECT *
		  FROM question
		 ORDER BY regdate desc
		 ) q
  ;
SELECT rownum, que.*
  FROM (
		SELECT q.*, a.admin_cd, a.ans_content
		  FROM question q, answer a
		 WHERE q.que_no = a.que_no(+)
		   AND mem_cd = 'M197407020003'
		   AND gb_del = 'N'
--		   AND thr_name like '%' || '시' || '%'
	   ORDER BY q.regdate DESC
	   ) que
;

		SELECT *
		  FROM theater
		 WHERE gb_del = 'N'
		 ;
		SELECT LISTAGG(thr_loc , ', ') WITHIN GROUP(ORDER BY thr_name) mem_cat
		  FROM theater
		 WHERE gb_del = 'N'
		 ;
		 
		
SELECT mlt.THR_NAME, t.THR_LOC 
  FROM mem_like_theater mlt, theater t
 WHERE mem_cd = 'M197407020003'
   AND mlt.THR_NAME = t.THR_NAME 
		
SELECT count(*)
  FROM (
SELECT mp.mpost_no
				 , MAX(mp.mem_cd) mem_cd
				 , MAX(mp.movie_cd) movie_cd
				 , MAX(mp.mpost_content) mpost_content
				 , MAX(mp.movie_pic_no) movie_pic_no
				 , MAX(mp.regdate) regdate
				 , MAX(movie_name) movie_name
				 , MAX(mem_id) mem_id
				 , MAX(mem_pic_path) mem_pic_path
				 , MAX(movie_pic_path) movie_pic_path
				 , count(ml.mpost_no) likecnt
				 , max(r.replycnt) replycnt
			FROM moviepost mp, movie m, MEMBER mb, movie_picture mpic, mp_like ml, (SELECT COUNT(*) replycnt, mpost_no
																					FROM reply
																					WHERE gb_del = 'N'
																					GROUP BY mpost_no) r
			WHERE mp.mem_cd = mb.mem_cd
			AND mp.movie_cd = m.movie_cd
			AND mp.movie_pic_no = mpic.movie_pic_no
			AND ml.mpost_no(+) = mp.mpost_no
			AND r.mpost_no(+) = mp.mpost_no
			AND mp.mem_cd = 'M197407020003'
			AND mp.gb_del = 'N'
			AND m.MOVIE_NAME like '%'|| '동' || '%'
			GROUP BY mp.mpost_no
);

SELECT m.MOVIE_NAME , r.*, mem.MEM_ID, mem.MEM_PIC_PATH, (
		  		SELECT count(*)
		  		  FROM review_like
		  		 WHERE REVIEW_NO = r.REVIEW_NO
		  		) reviewlike
		  FROM movie m, review r, MEMBER mem
		 WHERE m.MOVIE_CD = r.MOVIE_CD
 		   AND mem.MEM_CD = r.MEM_CD
 		   AND r.gb_del = 'N'
 		   AND mem.mem_cd = 'M197407020003'
 		   AND m.movie_name LIKE '%' || '' || '%'
 		   
 		   
SELECT m.MOVIE_CD 
	  ,m.movie_name
	  ,m.movie_grade
	  ,m.movie_mainpic_path
	  ,m2.mem_cd
	  ,(SELECT COUNT(*)
		FROM movie_like
		WHERE movie_cd = m.MOVIE_CD) likecount
  FROM MOVIE_LIKE ml, MOVIE m , "MEMBER" m2  
 WHERE ml.MEM_CD = m2.MEM_CD 
   AND ml.MOVIE_CD = m.MOVIE_CD 
   AND m2.MEM_CD = 'M197407020003'
;

SELECT m.MOVIE_CD , m.MOVIE_NAME, m.MOVIE_MAINPIC_PATH, s.STARTDATE
  FROM reservation r, movie m, screen s
 WHERE mem_cd = 'M197407020003'
   AND s.MOVIE_CD = m.MOVIE_CD 
GROUP BY m.MOVIE_CD 
;

SELECT * 
  FROM MOVIE_LIKE ml ;
INSERT ALL 
	INTO mem_like_theater(mem_cd, thr_name) 
	VALUES ('M197407020003', '부평점')
	INTO mem_like_theater(mem_cd, thr_name) 
	VALUES ('M197407020003', '강원점')
	INTO mem_like_theater(mem_cd, thr_name) 
	VALUES ('M197407020003', '테스트DW점')
	SELECT * FROM dual;