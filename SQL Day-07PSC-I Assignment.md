# Easy Level
## 1. Understanding JOINS (Theoretical)
    Explain the difference between `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN` with real-world examples.

Solution:-
`INNER JOIN` => It will fetch the row from both the table where common doesn't have any null values.
- Imagine we have a student table and a subject table. Inner Join will only give the records who opted for subject and subject which have student.

`LEFT JOIN` => It will fetch the row from the left table and matching rows from the right table. If there's no matching in the right table then it will return `null` values.
- If we Join student table  and subject table then it will return all the students. Even those who have not opted for Subject Yet.

`RIGHT JOIN` => It will fetch the row from the right table and matching rows from the left table. If there's no matching in the left table then it will return `null` values.
- If we Join student table  and subject table then it will return all the subject. Even those where no student is present.

`FULL OUTER JOIN` => It will return All the rows from both the table irrespective of the null values.
- It will return all the rows of student table and all the subject table.

## 2. Customers & Orders
- Given tables:
        customers(customer_id, name, email)
        orders(order_id, customer_id, total_amount, order_date)
- Write an SQL query to:
- Retrieve all customers who have placed an order.

        ```SQL
        SELECT c.customer_id, c.name, c.email
        FROM customers c
        INNER JOIN orders o
        ON c.customer_id = o.customer_id;
        ```
        List orders along with the customer names.

        ```SQL
        SELECT o.order_id, c.name
        FROM orders o
        INNER JOIN customers c 
        ON o.customer_id = c.customer_id;
        ```

        Find customers who haven’t placed any orders.

        ```SQL
        SELECT c.customer_id, c.name, c.email, o.order_id
        FROM customers c
        LEFT JOIN orders o ON c.customer_id = o.customer_id
        WHERE o.order_id IS NULL;
        ```


## 3. Employees & Departments
- Given tables:
        employees(emp_id, name, department_id, salary)
        departments(department_id, dept_name)
- Write a query to:
- Retrieve all employees and their department names, ensuring employees without a department are still listed.

```SQL
SELECT e.emp_id, e.name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;
```

- Find departments that have no employees.

```SQL
SELECT d.department_id, d.dept_name, e.emp_id
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;
```


4. Filtering with Aggregation & JOIN
- Given tables:
        students(student_id, name)
        courses(course_id, title)
        enrollments(student_id, course_id, grade)
- Write a query to:
- Retrieve the average grade per course.

```SQL
SELECT c.title, AVG(e.grade) AS Average_Grade
FROM enrollments e
JOIN courses c
ON e.course_id = c.course_id
GROUP BY c.title;
```

- List students who are not enrolled in any courses.

```SQL

SELECT s.student_id, s.name , e.student_id
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.course_id IS NULL;

```


- Find students who scored above the course average grade.

```SQL

SELECT e.student_id, s.name, e.course_id, c.title, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade > (
    SELECT AVG(e2.grade)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
);


```



# Medium Level (Complex JOINS & Aggregations)
## 1. Combining Multiple JOINS: Ezmployee & Manager Details
- Given tables:
        employees(emp_id, name, department_id, salary, manager_id)    
        departments(department_id, dept_name, manager_id)
        managers(manager_id, manager_name, bonus)
    Write an SQL query to:
- Retrieve all employees with their department name and manager details.

```SQL
select e.emp_id, e.name, e.salary,m.manager_name,
m.bonus, d.dept_name
from employees e
join departments d 
on e.department_id = d.department_id
join managers m on d.manager_id = m.manager_id;
```

- Find departments that do not have a manager assigned.

```SQL
SELECT d.dept_name,d.department_id,m.manager_id
FROM departments d
LEFT JOIN managers m 
ON d.manager_id = m.manager_id
WHERE m.manager_id IS NULL;
```


- Retrieve employees who earn more than their department’s average salary.

```SQL
select e.emp_id, e.name, d.dept_name, e.salary
from employees e 
join departments d ON e.department_id = d.department_id
where e.salary > (select avg(salary) 
from employees e1 where e.department_id = e1.department_id);
```



## 2. Product Sales Analysis with JOINS
- Given tables:
        products(product_id, product_name, category)
        orders(order_id, customer_id, order_date)
        order_items(order_item_id, order_id, product_id, quantity, price)
- Write SQL queries to:

- Retrieve all products that have never been sold.
```SQL
select p.product_name, p.product_id, o.order_id
from products p
left join order_items o
on p.product_id = o.product_id
where o.product_id is NULL;
```
- Find the top 3 best-selling products based on total quantity sold.
```SQL
select p.product_name, sum(o.quantity) as  Total_Sold
from products p
join order_items o
on p.product_id = o.product_id
group by p.product_name
order by Total_Sold desc
limit 3;
```

- Get the total revenue per product category.

```SQL

select p.category, sum(o.quantity * o.price) AS Total_Revenue
from products p
join order_itemS o
on p.product_ID = o.product_ID
group by p.category;

```


## 3. Advanced Filtering with JOINS: Employee Performance
- Given tables:
        employees(emp_id, name, salary, department_id)
        departments(department_id, dept_name, manager_id)
        projects(project_id, project_name, budget)
        employee_projects(emp_id, project_id, role)
- Write SQL queries to:
- Retrieve all employees and the projects they are working on.

```SQL
select e.emp_id, e.name, p.project_id, p.Project_Name
from employees e
left join employee_projects ep 
on e.emp_ID = ep.Emp_ID
left join projects p
on ep.Project_id = p.Project_id;
```
- Find employees who are not assigned to any project.

```SQL
select e.emp_id, e.name
from employees e
left join employee_projects ep 
on e.emp_id = ep.emp_id
where ep.project_id is null;

```
- List projects that have no employees assigned.

```SQL
select p.project_id, p.project_name
from projects p
left join employee_projects ep 
on ep.project_id = p.project_id
where ep.emp_id is null;
```
## 4. Customer Order Behavior Analysis
- Given tables:
        customers(customer_id, name, email)
        orders(order_id, customer_id, total_amount, order_date)
- Write SQL queries to:
- Find customers who have placed more than 5 orders.
        
```SQL
select c.customer_id,c.name,c.email, 
count(o.order_id) as Total_Order
from customers c
join orders o 
on o.customer_id = c.customer_id
group by c.name, c.customer_id
having count(o.order_id) > 5;
```
- Retrieve the total amount spent per customer.
        
```SQL
select c.customer_id, c.name, c.email, 
sum(o.total_amount) as Total_Spent
from customers c
join orders o 
on o.customer_id = c.customer_id
group by c.name, c.customer_id;
```

- Get customers who haven’t placed any orders in the last 6 months.
        
```SQL
select c.customer_id, c.name, c.email
from customers c
left join orders o 
on o.customer_id = c.customer_id and
 o.order_date >= date_sub(curdate(), INTERVAL 6 MONTH)
where o.order_id is null;
```

## 5. Mastering Aggregations with HAVING & JOINS
- Given a sales table with:
        sale_id, product_name, quantity, price, region
- Write queries to:
- Find total revenue per region, but only for regions where revenue exceeds $10,000.
```SQL

select region, sum(quantity * price) as Revanue
from sales
group by region
having Revanue > 10000;
```
- Retrieve the lowest revenue-generating product.
```SQL
select product_name, sum(quantity * price) as Revanue
from sales
group by product_name
order by Revanue asc
limit 1;
```
- Get the monthly revenue for the past 6 months.
```SQL

```
# Hard Level (Advanced JOINS & Real-World Scenarios)
1. Mastering SQL Joins: Employees, Departments, and Managers
-Given tables:
        employees(emp_id, name, department_id, salary)
        departments(department_id, dept_name, manager_id)
        managers(manager_id, manager_name, bonus)
- Write SQL queries to:
- Retrieve all employees with their department names and managers.
```SQL
select e.emp_id, e.name, d.dept_name, m.manager_name
from employees e
join departments d on d.department_id = e.department_id
join managers m on m.manager_id = d.manager_id;
```
- Find employees who earn more than their department’s average salary.
```SQL
select m.manager_id, m.manager_name, 
sum(e.salary) + m.bonus as total_Expense
from managers m
join departments d on m.manager_id = d.manager_id
join employees e on d.department_id = e.department_id
group by m.manager_id, m.manager_name, m.bonus;
```
- Calculate the total salary expense per manager, including bonus amounts.
```SQL

select m.manager_id, m.manager_name, 
sum(e.salary) + m.bonus as total_Expense
from managers m
join departments d on m.manager_id = d.manager_id
join employees e on d.department_id = e.department_id
group by m.manager_id, m.manager_name, m.bonus;

```
2. Complex Many-to-Many Relationship: Student-Course Enrollments
    Given tables:
        students(student_id, name)
        courses(course_id, title, credits)
        enrollments(student_id, course_id, grade)
- Write SQL queries to:
- Retrieve all students along with their enrolled courses.

```SQL
select s.student_id, s.name, c.title, e.grade
from students s
join enrollments e on e.student_id = s.student_id
join courses c on c.course_id = e.course_id;
```

- Find students who are enrolled in more than 3 courses.

```SQL
select s.student_id, s.name, count(e.course_id) as Total_Courses
from enrollments e 
join students s on e.student_id = s.student_id
group by e.student_id,s.name
having total_Courses > 3;
```

- Get the highest and lowest grades for each course.

```SQL

select e.course_id, c.title,
max(E.grade) as Highest_Grade, min(E.grade) as Lowest_Grade
from enrollments e 
join courses c on c.course_id = e.course_id
group by e.course_id,c.title;

```

3. E-commerce Data Analysis with JOINS & Aggregation
    Given tables:
        customers(customer_id, name, email)
        orders(order_id, customer_id, total_amount, order_date)
        order_items(order_item_id, order_id, product_id, quantity, price)
        products(product_id, product_name, category, supplier_id)
    * Wrie SQL queries to:
- Find the total revenue per customer, including product details.

```SQL
select c.customer_id, c.name, c.email,
o.total_amount as total_revenue,
SUM(oi.quantity * oi.price) AS topeeee_revenue
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
GROUP BY c.customer_id, c.name, p.product_name, o.total_amount
ORDER BY total_revenue DESC;
```

- Retrieve the top 5 customers based on total spending.

```SQL

```

- Get the most profitable product category.

```SQL

```

- Find customers who purchased products from at least 3 different categories.

```SQL

```


