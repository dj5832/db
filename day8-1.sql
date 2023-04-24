select *
  FROM countries;
select *
  FROM regions;
select *
  FROM locations;
select *
  FROM departments;
select *
  FROM employees;
select *
  FROM jobs;
-------------------------------------------------------------
select r.region_id, r.region_name, c.country_name
  FROM countries c, regions r
 where c.region_id = r.region_id
 AND r.region_id = 1;
--------------------------------------------------------------
select r.region_id, r.region_name, c.country_name, l.city 
  FROM countries c, regions r, locations l
 where c.region_id = r.region_id 
 AND c.country_id = l.country_id
 AND r.region_id = 1;
--------------------------------------------------------------
select r.region_id, r.region_name, c.country_name, l.city, d.department_name
  FROM countries c, regions r, locations l, departments d
 where c.region_id = r.region_id 
 AND c.country_id = l.country_id 
 and l.location_id = d.location_id 
 AND r.region_id = 1;
----------------------------------------------------------------
select r.region_id, r.region_name, c.country_name, l.city, d.department_name, e.first_name || e.last_name AS name 
  FROM countries c, regions r, locations l,departments d, employees e
 where c.region_id = r.region_id 
 AND c.country_id = l.country_id 
 AND l.location_id = d.location_id 
 AND d.department_id = e.department_id
 AND r.region_id = 1;
 -----------------------------------------------------------------
select e.employee_id, e.first_name || e.last_name AS name, j.job_id, j.job_title 
  FROM jobs j, employees e
 where j.job_id = e.job_id;
---------------------------------------------------------------------------
select e.manager_id, em.first_name || em.last_name AS MGR_name, e.employee_id, e.first_name || e.last_name AS name, j.job_id, j.job_title
  FROM jobs j, employees e, employees em
 where j.job_id = e.job_id 
 AND e.manager_id = em.employee_id ;