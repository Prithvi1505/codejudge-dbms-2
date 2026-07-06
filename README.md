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

# SARS - Student Academic Record System
## Part 2 — Software System Design: Architecture and Scalability (30 marks)

### Task 2.1 — Requirements and Architecture Choice
**Functional Requirements:**
1. Students can view marks and enroll in courses.
2. Admins can manage students, courses, and faculty.
3. Secure authentication for role-based access.

**Non-Functional Requirements:**
1. Handle 50,000 concurrent users (Scalability).
2. 99.9% availability during peak periods (Availability).
3. Secure data protection and authentication (Security).

**Architecture Recommendation**: Microservices
- Independent deployment and fault isolation are critical at this scale.
- Although management complexity is higher, it allows scaling individual services (e.g., Student Portal) independently.

### Task 2.2 — High-Level Design
**Main Components:**
- Authentication Service (REST API)
- Student Portal Service
- Admin Panel Service
- Email Notification Service
- Database Layer

**Student Portal Layers:**
- Presentation Layer: Handles UI and user requests.
- Business Layer: Enforces business rules (enrollment validation, mark calculation).
- Data Access Layer: Interacts with database.

**Scaling Strategy**: Horizontal scaling + Load Balancer (Least Connections algorithm) for even distribution during peak load.

**Elasticity**: Auto-scaling groups add servers during result publication and scale down during off-peak.

**Session Problem (Task 2.2e)**: Session stickiness issue.
- Strategy 1: Consistent hashing in load balancer.
- Strategy 2: Centralized Redis session store.
- Trade-offs discussed in system_design.md.

### Task 2.3 — Low-Level Design & SOLID
See:
- `lld_classes.py` (Student, Enrollment, Repository)
- `singleton_demo.py`
- `observer_demo.py`

**SOLID Application** explained in system_design.md.

### Task 2.4 — Redundancy and Fault Tolerance
- Database: Primary-Replica replication with failover.
- Microservices fault isolation allows Student Portal to continue if Email service fails.
- Synchronous replication trade-offs explained in system_design.md.

**Repository contains all required files.**
Submitted for Part 2.
