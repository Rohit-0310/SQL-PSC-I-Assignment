create database Day_07_Medium; 

use Day_07_Medium;

-- create employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(30),
    department_id INT,
    salary DECIMAL(10,2),
    manager_id INT
);

-- create departments Table

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    manager_id INT
);


-- create managers Table

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(30),
    bonus DECIMAL(10,2)
);


-- insert employees data

INSERT INTO employees (emp_id, name, department_id, salary, manager_id) VALUES
(1, 'John', 101, 67000, 1),
(2, 'Jane', 102, 90000, 2),
(3, 'Emily', 103, 85000, 3),
(4, 'Michael', NULL, 55000, NULL),
(5, 'Robert', 103, 65000, 3);


-- insert departments data

INSERT INTO departments (department_id, dept_name, manager_id) VALUES
(101, 'HR', 1),
(102, 'Finance', 2),
(103, 'IT', 3),
(104, 'Marketing', NULL);

-- insert managers data

INSERT INTO managers (manager_id, manager_name, bonus) VALUES
(1, 'Alice Johnson', 5000.00),
(2, 'Bob Smith', 4500.00),
(3, 'Charlie Brown', 4000.00);

select * from employees;
select * from departments;
select * from managers;

--  Retrieve all employees with their department name and manager details.

select e.emp_id, e.name, e.salary,m.manager_name,
m.bonus, d.dept_name
from employees e
join departments d 
on e.department_id = d.department_id
join managers m on d.manager_id = m.manager_id;


-- Find departments that do not have a manager assigned.

SELECT d.dept_name,d.department_id,m.manager_id
FROM departments d
LEFT JOIN managers m 
ON d.manager_id = m.manager_id
WHERE m.manager_id IS NULL;
-- Retrieve employees who earn more than their department’s average salary

select e.emp_id, e.name, d.dept_name, e.salary
from employees e 
join departments d ON e.department_id = d.department_id
where e.salary > (select avg(salary) 
from employees e1 where e.department_id = e1.department_id);

-- Q2. Product Sales Analysis with JOINS---------------

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(55),
    category VARCHAR(30)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2)
);

INSERT INTO products (product_id, product_name, category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Table', 'Furniture'),
(4, 'Chair', 'Furniture'),
(5, 'Headphones', 'Accessories'),
(6, 'Monitor', 'Electronics'),
(7, 'Keyboard', 'Electronics'),
(8, 'Sofa', 'Furniture'),
(9, 'Dining Table', 'Furniture'),
(10, 'Wireless Mouse', 'Accessories');

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(101, 1, '2025-02-10'),
(102, 2, '2025-02-11'),
(103, 1, '2025-02-12'),
(104, 3, '2025-02-13'),
(105, 2, '2024-02-14'),
(106, 4, '2024-02-15'),
(107, 5, '2024-02-16'),
(108, 3, '2024-02-17'),
(109, 1, '2024-02-18');


INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 101, 1, 1, 1200.00),
(2, 101, 2, 2, 800.00),
(3, 102, 3, 1, 300.00),
(4, 103, 4, 4, 150.00),
(5, 104, 5, 3, 100.00);

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


-- Retrieve all products that have never been sold.

select p.product_name, p.product_id, o.order_id
from products p
left join order_items o
on p.product_id = o.product_id
where o.product_id is NULL;
-- Find the top 3 best-selling products based on total quantity sold.

select p.product_name, sum(o.quantity) as  Total_Sold
from products p
join order_items o
on p.product_id = o.product_id
group by p.product_name
order by Total_Sold desc
limit 3;

-- Get the total revenue per product category.

select p.category, sum(o.quantity * o.price) AS Total_Revenue
from products p
join order_itemS o
on p.product_ID = o.product_ID
group by p.category;


