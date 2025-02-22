create database Day_07_Hard_Q3;

use Day_07_Hard_Q3;

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(30),
    email VARCHAR(40) UNIQUE
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE
);

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(30),
    category VARCHAR(30),
    supplier_id INT
);

-- Create Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2)
);

-- Insert Data into Customers
INSERT INTO customers (customer_id, name, email) VALUES 
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Davis', 'charlie@example.com'),
(4, 'David Brown', 'david@example.com'),
(5, 'Emma Wilson', 'emma@example.com');

-- Insert Data into Orders
INSERT INTO orders (order_id, customer_id, total_amount, order_date) VALUES 
(101, 1, 150.75, '2024-02-01'),
(102, 2, 320.50, '2024-02-03'),
(103, 3, 450.00, '2024-02-05'),
(104, 4, 120.99, '2024-02-07'),
(105, 5, 289.00, '2024-02-09');

-- Insert Data into Products
INSERT INTO products (product_id, product_name, category, supplier_id) VALUES 
(201, 'Laptop', 'Electronics', 1),
(202, 'Smartphone', 'Electronics', 2),
(203, 'Headphones', 'Accessories', 3),
(204, 'Keyboard', 'Accessories', 4),
(205, 'Desk Chair', 'Furniture', 5);

-- Insert Data into Order Items
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES 
(1, 101, 201, 1, 150.75),
(2, 102, 202, 2, 160.25),
(3, 103, 203, 3, 150.00),
(4, 104, 204, 1, 120.99),
(5, 105, 205, 2, 144.50);


select * from customers;
select * from orders;
select * from order_items;
select * from products;


-- Find the total revenue per customer, including product details.

select c.customer_id, c.name, c.email,
o.total_amount as total_revenue,
SUM(oi.quantity * oi.price) AS topeeee_revenue
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
GROUP BY c.customer_id, c.name, p.product_name, o.total_amount
ORDER BY total_revenue DESC;

-- Retrieve the top 5 customers based on total spending.
-- Get the most profitable product category.
-- Find customers who purchased products from at least 3 different categories.
