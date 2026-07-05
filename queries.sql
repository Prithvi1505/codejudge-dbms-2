-- a. Insert data
INSERT INTO Students (student_id, student_name, department, advisor_name, enrollment_year)
VALUES (1, 'Alice', 'CS', 'Dr. Smith', 2024),
       (2, 'Bob', 'CS', 'Dr. Smith', 2024),
       (3, 'Charlie', 'Math', 'Dr. Brown', 2023);

INSERT INTO Advisors (advisor_name, advisor_email)
VALUES ('Dr. Smith', 'smith@univ.edu');

INSERT INTO Courses (course_code, course_name, instructor_name)
VALUES ('CS101', 'Intro to CS', 'Prof. Johnson'),
       ('CS202', 'Data Structures', 'Prof. Lee');

INSERT INTO Instructors (instructor_name, instructor_email)
VALUES ('Prof. Johnson', 'johnson@univ.edu');

-- b. Safe UPDATE
UPDATE Instructors 
SET instructor_email = 'new.johnson@univ.edu' 
WHERE instructor_name = 'Prof. Johnson';

-- c. Safe DELETE
DELETE FROM Enrollments 
WHERE marks_obtained < 35;

-- d. DELETE from old flat table (with comment)
DELETE FROM StudentRecords;  -- Safer than TRUNCATE inside transactions
