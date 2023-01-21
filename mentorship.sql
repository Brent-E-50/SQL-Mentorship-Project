-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
	
CREATE TABLE employees (
	emp_no int NOT NULL,
	birth_date Date NOT NULL,
	first_name varchar NOT NULL,
	last_name varchar NOT NULL,
	gender varchar NOT NULL,
	hire_date Date NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager(
dept_no VARCHAR(4) NOT NULL,
	emp_no int NOT NULL,
	from_date Date NOT NULL,
	to_date Date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries(
	emp_no int NOT NULL,
	salary int NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
PRIMARY KEY (emp_no)
);

DROP TABLE dept_emp
CREATE TABLE dept_emp(
	dept_no VARCHAR(4) NOT NULL,
	emp_no int NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
	
);

DROP TABLE titles
CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no)REFERENCES Employees (emp_no),
PRIMARY KEY (emp_no, from_date)
);


SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM titles;
SELECT * FROM dept_emp
SELECT * FROM salaries
SELECT * FROM dept_manager
SELECT * FROM retirement_info2

--SELECT FROMs
-- 1. Retrieve the emp_no, first_name, and last_name columns from the
-- Employees table.
SELECT emp_no, first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- 2. Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date
FROM titles;

-- 3. Create a new table using the INTO clause.
-- 4. Join both tables on the primary key.
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
-- INTO retirement_info2
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM retirement_info2;
--5. Use Dictinct with Orderby to remove duplicate rows
-- filter to_date to '9999-01-01'
-- Create a Unique Titles table using the INTO clause.
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, to_date, title
-- INTO unique_titles2
FROM retirement_info2
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- 6. Write a query to retrieve the number of employees 
-- by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.
SELECT COUNT(title) as Number_of_titles, title
INTO retiring_titles_2
from unique_titles2
GROUP BY title
ORDER BY Number_of_titles DESC;


-- 7. Create a mentorship-eligibility 
--table that holds the current employees who 
--were born between January 1, 1965 and December 31, 1965.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
t.from_date, t.to_date, t.title
INTO mentorship_eligible
FROM employees e
JOIN titles t on e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' and '1965-12-31')
ORDER BY e.emp_no