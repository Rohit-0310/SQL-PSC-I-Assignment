CREATE DATABASE SQL_Day_07_PSC_I_Assignment;

USE SQL_Day_07_PSC_I_Assignment;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(25),
    email VARCHAR(40) UNIQUE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name, email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Brown', 'charlie@example.com'),
(4, 'David White', 'david@example.com');

INSERT INTO orders (order_id, customer_id, total_amount, order_date) VALUES
(101, 1, 250.00, '2025-01-10'),
(102, 2, 100.50, '2025-01-16'),
(103, 1, 300.75, '2025-02-04'),
(104, 3, 80.25, '2025-02-13');

SELECT * FROM customers;
SELECT * FROM orders;

SELECT c.customer_id, c.name, c.email
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;


SELECT o.order_id, c.name
FROM orders o
INNER JOIN customers c 
ON o.customer_id = c.customer_id;

-- Find customers who haven’t placed any orders.

SELECT c.customer_id, c.name, c.email, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q2 Employee

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    dept_name VARCHAR(30) UNIQUE
);

INSERT INTO departments (department_id, dept_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');

INSERT INTO employees (emp_id, name, department_id, salary) VALUES
(101, 'Alice', 1, 76000.00),
(102, 'Bob', 2, 65000.00),
(103, 'Charlie', NULL, 58000.00),
(104, 'David', 1, 98000.00),
(105, 'Emma', 3, 56000.00);

SELECT * FROM departments;
SELECT * FROM employees;
--  Retrieve all employees and their department names, ensuring employees without a department are still listed.

SELECT e.emp_id, e.name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

-- Find departments that have no employees.

SELECT d.department_id, d.dept_name, e.emp_id
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- 4. Filtering with Aggregation & JOIN

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(30)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    title VARCHAR(30)
);

CREATE TABLE enrollments (
    course_id INT,
    student_id INT,
    grade DECIMAL(5 , 2 ),
    PRIMARY KEY (student_id , course_id),
    FOREIGN KEY (student_id)
        REFERENCES students (student_id),
    FOREIGN KEY (course_id)
        REFERENCES courses (course_id)
);

select * from enrollments;

INSERT INTO students (student_id, name) 
VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

INSERT INTO courses (course_id, title) 
VALUES
(101, 'Math'),
(102, 'Phy'),
(103, 'CS');

INSERT INTO enrollments (student_id, course_id, grade) 
VALUES
(1, 101, 76.0),
(1, 102, 87.0),
(2, 101, 90.0),
(2, 103, 76.0),
(3, 102, 68.0),
(3, 103, 99.0);


-- Retrieve the average grade per course.

SELECT c.title, AVG(e.grade) AS Average_Grade
FROM enrollments e
JOIN courses c
ON e.course_id = c.course_id
GROUP BY c.title;


--  List students who are not enrolled in any courses.

SELECT s.student_id, s.name , e.student_id
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.course_id IS NULL;

--  Find students who scored above the course average grade.

SELECT e.student_id, s.name, e.course_id, c.title, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade > (
    SELECT AVG(e2.grade)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
);

