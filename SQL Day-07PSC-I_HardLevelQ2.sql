create database Day_07_Hard_Q2;

use Day_07_Hard_Q2;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(35)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    title VARCHAR(30),
    credits INT
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    grade DECIMAL(5,2)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'David Wilson'),
(5, 'Emma Davis'),
(6, 'Frank Thomas'),
(7, 'Grace White'),
(8, 'Henry Lewis');

INSERT INTO courses (course_id, title, credits) VALUES
(101, 'Mathematics', 3),
(102, 'Physics', 4),
(103, 'Computer Science', 3),
(104, 'History', 2),
(105, 'Biology', 4),
(106, 'Chemistry', 3);

INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 101, 85.5),
(1, 102, 78.0),
(1, 103, 92.0),
(2, 101, 88.0),
(2, 104, 90.0),
(2, 105, 76.5),
(3, 103, 95.0),
(3, 106, 82.0),
(4, 101, 67.5),
(4, 102, 89.0),
(4, 103, 74.5),
(4, 105, 91.0),
(5, 104, 87.0),
(5, 106, 73.5),
(6, 101, 80.0),
(6, 102, 85.0),
(6, 103, 88.0),
(6, 104, 92.0),
(6, 105, 79.0),
(7, 102, 94.0),
(7, 105, 86.5),
(8, 106, 75.0);



SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- Retrieve all students along with their enrolled courses.

select s.student_id, s.name, c.title, e.grade
from students s
join enrollments e on e.student_id = s.student_id
join courses c on c.course_id = e.course_id;

-- Find students who are enrolled in more than 3 courses.

select s.student_id, s.name, count(e.course_id) as Total_Courses
from enrollments e 
join students s on e.student_id = s.student_id
group by e.student_id,s.name
having total_Courses > 3;


-- Get the highest and lowest grades for each course.

select e.course_id, c.title,
max(E.grade) as Highest_Grade, min(E.grade) as Lowest_Grade
from enrollments e 
join courses c on c.course_id = e.course_id
group by e.course_id,c.title;

