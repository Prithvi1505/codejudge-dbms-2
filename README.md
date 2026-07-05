Task 1.1 — Normalization
a. Partial and Transitive Dependencies
Composite Key: (student_id, course_code)
Partial Dependencies (violate 2NF):

student_name, department, advisor_name, advisor_email, enrollment_year depend only on student_id (not on course_code).
course_name, instructor_name, instructor_email depend only on course_code.

Transitive Dependencies (violate 3NF/BCNF):

advisor_name → advisor_email
instructor_name → instructor_email

b. BCNF Decomposition
Table 1: Students

Primary Key: student_id
Columns: student_id, student_name, department, advisor_name, enrollment_year
Resolves: Partial dependency on student_id

Table 2: Advisors

Primary Key: advisor_name
Columns: advisor_name, advisor_email
Resolves: Transitive dependency

Table 3: Courses

Primary Key: course_code
Columns: course_code, course_name, instructor_name
Resolves: Partial dependency on course_code

Table 4: Instructors

Primary Key: instructor_name
Columns: instructor_name, instructor_email
Resolves: Transitive dependency

Table 5: Enrollments

Composite Primary Key: (student_id, course_code)
Columns: student_id, course_code, marks_obtained
Foreign Keys: student_id → Students, course_code → Courses
Resolves: Remaining many-to-many relationship

c. Data Integrity Check

Entity Integrity: Satisfied (all PKs are defined and NOT NULL)
Referential Integrity: Satisfied (FKs defined)
Domain Integrity: Satisfied (appropriate data types + CHECK constraints possible)
User-defined Integrity: Satisfied

