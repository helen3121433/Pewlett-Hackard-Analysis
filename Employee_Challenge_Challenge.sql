-- Deliverable 1 -- 
-- Create table for retirement titles
-- SELECT emp_no, first_name,last_name from employees table
-- SELECT title, from date and to date from titles table
-- Inner join employees table to title table on emp_no (primary key)
-- FILTER only the birthdate between 1952 to 1955
-- ORDER BY employee numbers
-- INTO: create a new table that contains info above 
SELECT e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN title as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;
--DROP TABLE retirement_titles;

-- Create unique title table
-- SELECT employee number, first name, last name and title from retirments_titles table
-- DISTINCT ON employer number so that only retreve first occurence of employee numbers.
-- Filter to employee who still a current employee of this company
-- order by employee number, and desc order by date
SELECT DISTINCT ON(rt.emp_no) rt.emp_no, rt.first_name, rt.last_name, rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;


-- retiring_title
-- COUNT the number of title that are going to be retire.
SELECT count(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count(ut.title) DESC;

SELECT * FROM retiring_titles;
-- DROP TABLE retiring_titles;

-------------------------------------

-- Delivable 2 -- 
-- Create a Mentorship Eligibilty table
-- SELECT first occurence of employment number, first name, last name, birthdate from "employees" table
-- SELECT employees'from date and to date from "dept_emp" table
-- SELECT title from title table
-- First inner join employees and dept_emp table only looking for employee number
-- then inner join employee and title for looking for employee numbers
-- Use INNER JOIN, so that only looking for data that exist in both tables.
-- FILTER by retiring employees that are still working in this company
SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN title AS ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01'AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibilty;
-- DROP TABLE mentorship_eligibilty;

SELECT COUNT(me.emp_no) FROM mentorship_eligibilty AS me;
-- 1549

-------------------------------------

-- Deliverable 3 -- 
SELECT COUNT(emp_no)AS Count_of_title_Job 
FROM retirement_titles;
-- 133776

SELECT COUNT(emp_no) AS Count_of_employee
FROM unique_titles;
-- 72458

--SELECT COUNT(rt.emp_no) AS Count_of_title_Job FROM retirement_titles as rt
--UNION SELECT COUNT(ut.emp_no) AS Count_of_employee FROM unique_titles as ut; 

-- creat a table to find the department name of each employer number
SELECT me.emp_no, d.dept_name, d.dept_no
INTO mentorship_dept
FROM mentorship_eligibilty AS me
INNER JOIN dept_emp AS de
ON (me.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT * FROM mentorship_dept;
--select count(mentorship_dept.emp_no) FROM mentorship_dept;

-- count how many eligbility mentorship in each department
SELECT count(md.dept_no), md.dept_name
INTO count_mentorship
FROM mentorship_dept AS md
GROUP BY md.dept_name
ORDER BY count(md.dept_no);

SELECT * FROM count_mentorship;

SELECT SUM(count_mentorship.count) FROM count_mentorship;
-- 1708

