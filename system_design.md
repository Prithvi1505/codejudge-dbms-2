# SARS System Design

## Task 2.1 — Requirements

**Functional Requirements:**
1. Students can view their marks and enroll in courses.
2. Admins can manage students, courses, and faculty.
3. Users can authenticate and access role-based portals.

**Non-Functional Requirements:**
1. Handle 50,000 concurrent users (Scalability).
2. 99.9% availability during result days (Availability).
3. Secure authentication and data protection (Security).

## Task 2.1b — Architecture Choice

**Monolithic vs Microservices:**

- **Independent Deployment**: Microservices allow deploying one service without affecting others. Monolith requires full redeployment.
- **Fault Isolation**: Microservices isolate failures (email service crash doesn't stop student portal). Monolith brings down the entire app.
- **Management Complexity**: Monolith is simpler to develop and deploy initially. Microservices add complexity (service discovery, monitoring).

**Recommendation**: Microservices. At 50,000 concurrent users, fault isolation and independent scaling are critical. Although more complex, it better supports the scale and future growth.

## Task 2.2 — High-Level Design

**Main Components:**
- Authentication Service (REST API)
- Student Portal Service (REST API)
- Admin Panel Service (REST API)
- Database (MySQL/PostgreSQL)
- Email Notification Service

**Student Portal Layers:**
- Presentation Layer: Handles UI and user input.
- Business Layer: Contains business logic (enrollment rules, mark calculation).
- Data Access Layer: Interacts with database.

**Scaling & Load Balancing:**
- Horizontal scaling for web servers.
- Load balancer uses Least Connections algorithm (suitable for uneven load during peak times).

**Elasticity**: Auto-scaling groups add/remove servers based on CPU/load during peak and off-peak periods.

**Task 2.2e — Session Problem:**
Problem: Session Stickiness / Sticky Sessions issue.
Strategy 1 (Routing): Use consistent hashing in load balancer.
Strategy 2 (Storage): Use centralized Redis session store.
Trade-offs: Routing may cause imbalance; centralized storage adds latency/cost but improves fault tolerance.
