create database Day_07_Medium_Q4;

use Day_07_Medium_Q4;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(30),
    email VARCHAR(50) UNIQUE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO customers (customer_id, name, email) 
VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'David', 'david@example.com'),
(5, 'Emma', 'emma@example.com');


INSERT INTO orders (order_id, customer_id, total_amount, order_date) 
VALUES
(101, 1, 250.75, '2024-02-01'),
(102, 2, 400.50, '2024-02-05'),
(103, 3, 150.00, '2024-02-10'),
(104, 1, 320.25, '2024-02-15'),
(105, 4, 500.00, '2024-02-20'),
(106, 2, 275.60, '2024-02-25'),
(107, 1, 200.00, '2023-08-01'),
(108, 1, 180.50, '2023-09-10'),
(109, 1, 275.30, '2023-10-15'),
(110, 1, 190.75, '2023-11-20'),
(111, 2, 500.00, '2023-12-25'),
(112, 2, 650.75, '2023-06-30'),
(113, 3, 120.00, '2023-07-15'),
(114, 3, 300.00, '2023-08-22'),
(115, 3, 450.50, '2023-09-05'),
(116, 4, 380.00, '2023-03-11'),
(117, 4, 260.40, '2023-04-25'),
(118, 5, 330.00, '2023-05-30'),
(119, 5, 290.00, '2023-06-15'),
(120, 5, 400.75, '2023-07-20'),
(121, 1, 250.75, '2025-02-01');


SELECT * FROM customers;
SELECT * FROM orders;

-- Find customers who have placed more than 5 orders.

select c.customer_id,c.name,c.email, 
count(o.order_id) as Total_Order
from customers c
join orders o 
on o.customer_id = c.customer_id
group by c.name, c.customer_id
having count(o.order_id) > 5;


-- Retrieve the total amount spent per customer.

select c.customer_id, c.name, c.email, 
sum(o.total_amount) as Total_Spent
from customers c
join orders o 
on o.customer_id = c.customer_id
group by c.name, c.customer_id;

-- Get customers who haven’t placed any orders in the last 6 months.

select c.customer_id, c.name, c.email
from customers c
left join orders o 
on o.customer_id = c.customer_id and
 o.order_date >= date_sub(curdate(), INTERVAL 6 MONTH)
where o.order_id is null;


-- 5. Having And JOINS


CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(35),
    quantity INT NOT NULL,
    price DECIMAL(10,2),
    region VARCHAR(35)
);

INSERT INTO sales (sale_id, product_name, quantity, price, region) VALUES
(1, 'Laptop', 10, 1200, 'North'),
(2, 'Laptop', 5, 1200, 'South'),
(3, 'Phone', 20, 800, 'North'),
(4, 'Phone', 15, 800, 'West'),
(5, 'Tablet', 8, 500, 'East'),
(6, 'Tablet', 10, 500, 'North'),
(7, 'Monitor', 5, 300, 'South'),
(8, 'Monitor', 7, 300, 'West');

select * from sales;

-- Find total revenue per region, but only for regions where revenue exceeds $10,000.

select region, sum(quantity * price) as Revanue
from sales
group by region
having Revanue > 10000;

-- Retrieve the lowest revenue-generating product.

select product_name, sum(quantity * price) as Revanue
from sales
group by product_name
order by Revanue asc
limit 1;
-- Get the monthly revenue for the past 6 months.

-- we don't have date field in our data;




