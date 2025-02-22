create database Day_07_Hard_Q1;

use Day_07_Hard_Q1;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(30),
    department_id INT,
    salary DECIMAL(10,2)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    manager_id INT
);

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(30),
    bonus DECIMAL(10,2)
);

-- insert data----
INSERT INTO employees (emp_id, name, department_id, salary) VALUES
(1, 'Alice', 101, 60000.00),
(2, 'Bob', 102, 75000.00),
(3, 'Charlie', 101, 55000.00),
(4, 'David', 103, 90000.00),
(5, 'Eve', 102, 65000.00);

INSERT INTO departments (department_id, dept_name, manager_id) VALUES
(101, 'Sales', 1001),
(102, 'Marketing', 1002),
(103, 'IT', 1003);

INSERT INTO managers (manager_id, manager_name, bonus) VALUES
(1001, 'John Smith', 10000.00),
(1002, 'Jane Doe', 15000.00),
(1003, 'Mike Johnson', 12000.00);

select * from employees;
select * from departments;
select * from managers;

-- Retrieve all employees with their department names and managers.

select e.emp_id, e.name, d.dept_name, m.manager_name
from employees e
join departments d on d.department_id = e.department_id
join managers m on m.manager_id = d.manager_id;

-- Find employees who earn more than their department’s average salary.

select e.emp_id, e.name, d.dept_name, e.Salary
from employees e
join departments d on d.department_id = e.department_id
where e.salary > (select avg(e2.salary) 
from employees e2 where e2.department_id = e.department_id);

-- Calculate the total salary expense per manager, including bonus amounts.

select m.manager_id, m.manager_name, 
sum(e.salary) + m.bonus as total_Expense
from managers m
join departments d on m.manager_id = d.manager_id
join employees e on d.department_id = e.department_id
group by m.manager_id, m.manager_name, m.bonus;

