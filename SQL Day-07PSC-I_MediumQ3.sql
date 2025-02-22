
create database Day_07_Medium_Q3;
use Day_07_Medium_Q3;


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(30),
    salary DECIMAL(10,2),
    department_id INT
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    manager_id INT
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(30),
    budget DECIMAL(12,2)
);

CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    role VARCHAR(30)
);


INSERT INTO employees (emp_id, name, salary, department_id) VALUES
(201, 'Alice', 75000.00, 1),
(202, 'Bob', 80000.00, 2),
(203, 'Charlie', 90000.00, 1),
(204, 'David', 85000.00, 3),
(205, 'Emma', 95000.00, 4);

INSERT INTO projects (project_id, project_name, budget) VALUES
(301, 'Website Redesign', 50000.00),
(302, 'HR System Upgrade', 60000.00),
(303, 'Financial Reporting Tool', 80000.00),
(304, 'Digital Marketing Campaign', 70000.00);

INSERT INTO departments (department_id, dept_name, manager_id) VALUES
(1, 'IT', 101),
(2, 'HR', 102),
(3, 'Finance', 103),
(4, 'Marketing', 104);

INSERT INTO employee_projects (emp_id, project_id, role) VALUES
(201, 301, 'Developer'),
(202, 302, 'HR Lead'),
(203, 301, 'Team Lead'),
(204, 303, 'Financial Analyst'),
(205, 304, 'Marketing Manager'),
(201, 303, 'Consultant'),
(202, 304, 'Coordinator');


SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM projects;
SELECT * FROM employee_projects;

-- Retrieve all employees and the projects they are working on.

select e.emp_id, e.name, p.project_id, p.Project_Name
from employees e
left join employee_projects ep 
on e.emp_ID = ep.Emp_ID
left join projects p
on ep.Project_id = p.Project_id;

-- Find employees who are not assigned to any project.

select e.emp_id, e.name
from employees e
left join employee_projects ep 
on e.emp_id = ep.emp_id
where ep.project_id is null;

-- List projects that have no employees assigned.

select p.project_id, p.project_name
from projects p
left join employee_projects ep 
on ep.project_id = p.project_id
where ep.emp_id is null;
