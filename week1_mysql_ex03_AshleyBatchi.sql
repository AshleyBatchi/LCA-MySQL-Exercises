-- =========================================================================
-- COURSE 2 – BACKEND WEB DEVELOPMENT: EXERCISE 03
-- TOPIC: SQL JOINS AND DATA MANIPULATION
-- STUDENT: Ashley Batchi
-- =========================================================================

-- Ensure we are using the correct database
USE edutrack_sa;

-- =========================================================================
-- SECTION 1: INNER JOINS
-- =========================================================================

-- TASK 1: INNER JOIN across 3 tables (Enrolment list)
SELECT 
    t.first_name, 
    t.last_name, 
    c.course_name, 
    e.enrolment_date, 
    e.status
FROM enrolments e
INNER JOIN trainees t ON e.trainee_id = t.trainee_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- TASK 2: INNER JOIN (Course and Facilitator name pairing)
SELECT 
    c.course_name, 
    f.first_name, 
    f.last_name
FROM courses c
INNER JOIN facilitators f ON c.facilitator_id = f.facilitator_id;

-- =========================================================================
-- SECTION 2: OUTER JOINS
-- =========================================================================

-- TASK 3: LEFT JOIN (Full trainee list with course name, showing NULL for unenrolled)
SELECT 
    t.first_name, 
    t.last_name, 
    c.course_name
FROM trainees t
LEFT JOIN enrolments e ON t.trainee_id = e.trainee_id
LEFT JOIN courses c ON e.course_id = c.course_id;

-- TASK 4: RIGHT JOIN (Full course list with trainee names, showing NULL for empty courses)
SELECT 
    c.course_name, 
    t.first_name, 
    t.last_name
FROM enrolments e
INNER JOIN trainees t ON e.trainee_id = t.trainee_id
RIGHT JOIN courses c ON e.course_id = c.course_id;

-- =========================================================================
-- SECTION 3: DATA MANIPULATION (DML)
-- =========================================================================

-- TASK 5: UPDATE province change using a WHERE condition
UPDATE trainees 
SET province = 'Western Cape' 
WHERE trainee_id = 2;

-- TASK 6: UPDATE enrolment status using a WHERE condition
UPDATE enrolments 
SET status = 'Completed' 
WHERE enrolment_id = 1;

-- TASK 7: DELETE specific enrolment using ORDER BY and LIMIT
DELETE FROM enrolments 
WHERE status = 'Withdrawn' 
ORDER BY enrolment_date DESC 
LIMIT 1;

-- =========================================================================
-- SECTION 4: THE MINI CHALLENGE
-- =========================================================================

-- TASK 8: Single query combining JOIN, WHERE, GROUP BY, HAVING, and ORDER BY
SELECT 
    c.course_name, 
    COUNT(e.trainee_id) AS total_active_enrolments
FROM courses c
INNER JOIN enrolments e ON c.course_id = e.course_id
WHERE e.status = 'Active'
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.trainee_id) > 0
ORDER BY total_active_enrolments DESC;

-- =========================================================================
-- SECTION 5: STRETCH GOALS
-- =========================================================================

-- STRETCH GOAL 1: Facilitator with the most trainees across all courses
SELECT 
    f.first_name, 
    f.last_name, 
    COUNT(e.trainee_id) AS total_trainees
FROM facilitators f
INNER JOIN courses c ON f.facilitator_id = c.facilitator_id
INNER JOIN enrolments e ON c.course_id = e.course_id
GROUP BY f.facilitator_id
ORDER BY total_trainees DESC
LIMIT 1;

-- STRETCH GOAL 2: Add facilitator, course, and enrol 2 trainees in one block
INSERT INTO facilitators (first_name, last_name, email, phone) 
VALUES ('Mandla', 'Nkosi', 'mandla.nkosi@edutrack.co.za', '0812345678');

INSERT INTO courses (course_name, duration_weeks, facilitator_id) 
VALUES ('Advanced SQL and Relational Data', 6, LAST_INSERT_ID());

INSERT INTO enrolments (trainee_id, course_id, enrolment_date, status) 
VALUES 
(1, LAST_INSERT_ID(), '2026-07-23', 'Active'),
(3, LAST_INSERT_ID(), '2026-07-23', 'Active');

-- STRETCH GOAL 3: Find all trainees enrolled in more than one course
SELECT 
    t.first_name, 
    t.last_name, 
    COUNT(e.course_id) AS total_courses
FROM trainees t
INNER JOIN enrolments e ON t.trainee_id = e.trainee_id
GROUP BY t.trainee_id, t.first_name, t.last_name
HAVING COUNT(e.course_id) > 1;