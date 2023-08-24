SELECT *
  FROM ACCOUNTCHECK a ;
  
 
 SELECT *
		  FROM question q, answer a
		 WHERE q.que_no = a.que_no(+)
		   AND mem_cd = 'M202308140109'
		   AND gb_del = 'N'
		   ORDER BY q.regdate DESC;
		   
		  SELECT rownum, que.*
		  FROM (
				SELECT q.*, a.admin_cd, a.ans_content
				  FROM question q, answer a
				 WHERE q.que_no = a.que_no(+)
				   AND mem_cd = 'M202308140109'
				   AND gb_del = 'N'
			   ORDER BY q.regdate DESC
			   ) que
			WHERE rownum <= 5;
			   
SELECT *
	  FROM (
			SELECT r.merchant_uid
				  ,LISTAGG(r.MEM_CAT , ', ') WITHIN GROUP(ORDER BY r.mem_cat) mem_cat
				  ,LISTAGG(r.RES_SEAT , ', ') WITHIN GROUP(ORDER BY res_seat)  res_seat
				  ,MAX(startdate) startdate
				  ,MAX(RESDATE) RESDATE
				  ,MAX(h.house_name) house_name
				  ,MAX(h.thr_name) thr_name
				  ,MAX(REFUNDDATE) REFUNDDATE
				  ,MAX(m.movie_name) movie_name
				  ,MAX(m.movie_cd) movie_cd
				  ,MAX(m.movie_mainpic_path) movie_mainpic_path
				  ,MAX(pt.gb_print) gb_print
			  FROM reservation r
			  	  ,screen s
			  	  ,movie m
			  	  ,house h
			  	  ,PAY_DETAIL p
			  	  ,photo_ticket pt
			 WHERE r.mem_cd = 'M202308140104'
			   AND s.screen_cd = r.screen_cd 
			   AND s.movie_cd = m.movie_cd
			   AND h.house_no = s.house_no
			   AND p.merchant_uid = r.merchant_uid
			   AND p.merchant_uid = pt.merchant_uid(+)
			   AND r.
			   AND STARTdate > sysdate
			 GROUP BY r.merchant_uid
			 ORDER BY r.merchant_uid
			 )
 	WHERE rownum <= 1;
 	
 SELECT *
		FROM (
			SELECT p.*, product_name point_name
			FROM point p, mem_buy mb, product pd
			WHERE p.relate_cd = mb.merchant_uid
			AND pd.product_cd = mb.product_cd
			AND p.mem_cd = 'M202308140104'
			 UNION ALL
			SELECT p.*, product_name point_name
			FROM point p, mem_product mp, product pd
			WHERE mp.mem_product_cd = p.relate_cd
			AND mp.product_cd = pd.product_cd
			AND p.mem_cd = 'M202308140104'
			 UNION ALL
			SELECT p.*, movie_name point_name
			FROM point p, screen s, movie m, (SELECT merchant_uid, max(screen_cd) screen_cd FROM reservation WHERE mem_cd = 'M202308140104' GROUP BY merchant_uid) r
			WHERE p.relate_cd = r.merchant_uid
			AND r.screen_cd = s.screen_cd
			AND s.movie_cd = m.movie_cd
			AND p.mem_cd = 'M202308140104'
			)
		WHERE rownum <= 5
		ORDER BY regdate DESC;
		