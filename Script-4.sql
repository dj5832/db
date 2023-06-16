CREATE USER spring IDENTIFIED BY spring
DEFAULT tablespace TS_DBSQL
TEMPORARY tablespace temp
quota unlimited ON TS_DBSQL
quota 0m ON system;
GRANT CONNECT, resource TO spring;