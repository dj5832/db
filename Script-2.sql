ALTER TABLE STUDENTS DROP COLUMN stu_pwd;

ALTER TABLE STUDENTS ADD stu_pwd VARCHAR(255);

UPDATE STUDENTS SET STU_PWD = '123456';

ALTER TABLE STAFFS  DROP COLUMN staff_pwd;

ALTER TABLE STAFFS  ADD staff_pwd VARCHAR(255);

UPDATE STAFFS SET STAFF_PWD = '123456';