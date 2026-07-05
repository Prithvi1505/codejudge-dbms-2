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


-- a. IN operator
SELECT student_name, course_name 
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_code = c.course_code
WHERE c.course_code IN ('CS101', 'CS202', 'CS303');

-- b. BETWEEN and IS NOT NULL
SELECT student_name, marks_obtained 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE marks_obtained BETWEEN 60 AND 85 
  AND advisor_email IS NOT NULL;

-- c. GROUP BY + HAVING
SELECT department, AVG(marks_obtained) as avg_marks,
       MIN(marks_obtained), MAX(marks_obtained)
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY department
HAVING AVG(marks_obtained) > 55;

-- d. INNER vs LEFT JOIN
SELECT s.student_name, c.course_name, e.marks_obtained
FROM Students s
INNER JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_code = c.course_code;

SELECT s.student_name, c.course_name, e.marks_obtained
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Courses c ON e.course_code = c.course_code;

-- e. Correlated subquery
SELECT s.student_name, e.marks_obtained
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.marks_obtained > (
    SELECT AVG(marks_obtained) 
    FROM Enrollments e2 
    JOIN Students s2 ON e2.student_id = s2.student_id 
    WHERE s2.department = s.department
);

-- f. EXCEPT (students in 2024 but not 2025)
SELECT student_id FROM Enrollments WHERE enrollment_year = 2024
EXCEPT
SELECT student_id FROM Enrollments WHERE enrollment_year = 2025;

-- g. Second-highest marks per department
SELECT student_name, marks_obtained, department
FROM (
    SELECT s.student_name, e.marks_obtained, s.department,
           DENSE_RANK() OVER (PARTITION BY s.department ORDER BY e.marks_obtained DESC) as rnk
    FROM Students s
    JOIN Enrollments e ON s.student_id = e.student_id
) t
WHERE rnk = 2;

-- h. Window functions
SELECT student_name, department, marks_obtained,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY marks_obtained DESC) as row_num,
       RANK() OVER (PARTITION BY department ORDER BY marks_obtained DESC) as rank,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY marks_obtained DESC) as dense_rank
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id;
