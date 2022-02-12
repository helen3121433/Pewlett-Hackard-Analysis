-- Creating tables for PH-EmployeeDB
-- F5 key 
CREATE TABLE departments(
	-- create a column named "dept_no" that can hold up to four varying characters
	-- while NOT NULL tells SQL that no null fields will be allowed when importing data.
	-- If we didn't have the NOT NULL constraint, then there's a change that a row won't have a primary key associated with data
	dept_no VARCHAR(4) NOT NULL, 
	-- create a column similar to the dept_no
	-- only the varying character count has a maximum of 40.
	dept_name VARCHAR(40) NOT NULL,
	-- PRIMARY KEY() means that dept_no column is used as the primary key for this table
	PRIMARY KEY (dept_no),
	-- UNIQUE() add the unique constraint to the dept_name column
	UNIQUE (dept_name)
);

create table employees(
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

SELECT * FROM departments;