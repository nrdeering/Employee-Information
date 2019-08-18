--Drop existing tables, putting the Primary Key tables at the bottom of the list
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Department_Manager;
DROP TABLE IF EXISTS Department_Employee;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    emp_no INTEGER   NOT NULL,
    birth_date VARCHAR   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hire_date VARCHAR   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Titles (
    emp_no INT   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

CREATE TABLE Salaries (
    emp_no INT   NOT NULL,
    salary INTEGER   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

CREATE TABLE Department_Manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

CREATE TABLE Department_Employee (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

CREATE TABLE Departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

--COMMENT THESE OUT!!!!

--ALTER TABLE Titles ADD CONSTRAINT fk_Titles_emp_no FOREIGN KEY(emp_no)
--REFERENCES Employees (emp_no);

--ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
--REFERENCES Employees (emp_no);

--ALTER TABLE Department_Manager ADD CONSTRAINT fk_Department_Manager_dept_no FOREIGN KEY(dept_no)
--REFERENCES Departments (dept_no);

--ALTER TABLE Department_Manager ADD CONSTRAINT fk_Department_Manager_emp_no FOREIGN KEY(emp_no)
--REFERENCES Employees (emp_no);

--ALTER TABLE Department_Employee ADD CONSTRAINT fk_Department_Employee_emp_no FOREIGN KEY(emp_no)
--REFERENCES Employees (emp_no);

--ALTER TABLE Department_Employee ADD CONSTRAINT fk_Department_Employee_dept_no FOREIGN KEY(dept_no)
--REFERENCES Departments (dept_no);



--List the following details of each employee: employee number, last name, first name, gender, and salary
SELECT * FROM employees;

SELECT emp.emp_no, emp.last_name, emp.first_name, emp.gender, sal.salary
FROM Employees emp
JOIN Salaries sal
ON emp.emp_no = sal.emp_no;

--List employees who were hired in 1986.

SELECT last_name, first_name, hire_date
FROM Employees
WHERE (hire_date LIKE '%%/%%/1986');

--List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.

SELECT mngr.dept_no, dept_name, mngr.emp_no, first_name, last_name, mngr.from_date, mngr.to_date
FROM Department_Manager mngr
LEFT JOIN Departments ON mngr.dept_no = Departments.dept_no
LEFT JOIN Employees ON mngr.emp_no = Employees.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT emp.emp_no, last_name, first_name, dept_name
FROM Employees emp
LEFT JOIN Department_Employee dpt ON emp.emp_no = dpt.emp_no
LEFT JOIN Departments ON dpt.dept_no = Departments.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."

SELECT  first_name, last_name
FROM Employees emp
WHERE (first_name LIKE 'Hercules' AND last_name LIKE 'B%');

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
--***Similar to question 4, only include sales

SELECT emp.emp_no, last_name, first_name, dept_name
FROM Employees emp
LEFT JOIN Department_Employee dpt ON emp.emp_no = dpt.emp_no
LEFT JOIN Departments ON dpt.dept_no = Departments.dept_no
WHERE dept_name LIKE 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
--Similar to questions 4 and 6, add 'OR' in the conditional 

SELECT emp.emp_no, last_name, first_name, dept_name
FROM Employees emp
LEFT JOIN Department_Employee dpt ON emp.emp_no = dpt.emp_no
LEFT JOIN Departments ON dpt.dept_no = Departments.dept_no
WHERE dept_name LIKE 'Sales' OR  dept_name LIKE 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) AS "name_freq"
FROM Employees
GROUP BY last_name
ORDER BY name_freq DESC;
