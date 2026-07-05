DROP DATABASE IF EXISTS university_db;
CREATE DATABASE university_db;
USE university_db;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    advisor_name VARCHAR(100),
    enrollment_year INT DEFAULT YEAR(CURRENT_DATE)
);

CREATE TABLE Advisors (
    advisor_name VARCHAR(100) PRIMARY KEY,
    advisor_email VARCHAR(100) UNIQUE
);

CREATE TABLE Courses (
    course_code VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_name VARCHAR(100)
);

CREATE TABLE Instructors (
    instructor_name VARCHAR(100) PRIMARY KEY,
    instructor_email VARCHAR(100) UNIQUE
);

CREATE TABLE Enrollments (
    student_id INT,
    course_code VARCHAR(10),
    marks_obtained DECIMAL(5,2),
    PRIMARY KEY (student_id, course_code),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_code) REFERENCES Courses(course_code)
);
