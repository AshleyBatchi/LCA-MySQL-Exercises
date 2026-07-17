-- =========================================================================
-- COURSE 2 – BACKEND WEB DEVELOPMENT: EXERCISE 02
-- TOPIC: QUERYING, SORTING, AND FILTERING DATA
-- STUDENT FILE: week1_mysql_ex02_AshleyBatchi.sql
-- TARGET DATABASE: edutrack_sa
-- =========================================================================

-- Ensure target database context is active
USE edutrack_sa;


-- =========================================================================
-- SECTION 1: SORTING AND LIMITING DATA (ORDER BY, LIMIT, OFFSET)
-- =========================================================================

-- TASK 1: Retrieve all trainees sorted by surname (last name) in ascending order
SELECT * 
FROM trainees 
ORDER BY last_name ASC;

-- TASK 2: Retrieve all courses sorted by duration in weeks in descending order
SELECT * 
FROM courses 
ORDER BY duration_weeks DESC;

-- TASK 3: Retrieve the 3 most recently enrolled records using LIMIT
SELECT * 
FROM enrolments 
ORDER BY enrolment_date DESC 
LIMIT 3;

-- STRETCH GOAL 1: Retrieve the 2nd and 3rd most recently enrolled records (LIMIT with OFFSET)
SELECT * 
FROM enrolments 
ORDER BY enrolment_date DESC 
LIMIT 2 OFFSET 1;


-- =========================================================================
-- SECTION 2: FILTERING DATA (WHERE, LIKE, WILDCARDS)
-- =========================================================================

-- TASK 4: Filter trainees located in 'Gauteng'
SELECT * 
FROM trainees 
WHERE province = 'Gauteng';

-- TASK 5: Filter trainees whose first name starts with the letter 'A'
SELECT * 
FROM trainees 
WHERE first_name LIKE 'A%';

-- TASK 6: Filter courses with a duration greater than or equal to 8 weeks
SELECT * 
FROM courses 
WHERE duration_weeks >= 8;

-- TASK 7: Filter enrolments with status set to 'Active'
SELECT * 
FROM enrolments 
WHERE status = 'Active';

-- STRETCH GOAL 2: Find all trainees whose email ends with '.co.za' or '.co.za' domain extensions
SELECT * 
FROM trainees 
WHERE email LIKE '%.co.za' OR email LIKE '%.student.co.za';


-- =========================================================================
-- SECTION 3: AGGREGATE FUNCTIONS & SUMMARY CALCULATIONS
-- =========================================================================

-- TASK 8: Calculate the total number of registered trainees
SELECT COUNT(*) AS total_trainees 
FROM trainees;

-- TASK 9: Calculate the average and maximum course duration across all courses
SELECT 
    AVG(duration_weeks) AS average_duration_weeks, 
    MAX(duration_weeks) AS max_duration_weeks 
FROM courses;

-- TASK 10: Count the total number of enrolments per course ID
SELECT 
    course_id, 
    COUNT(*) AS total_enrolments 
FROM enrolments 
GROUP BY course_id;


-- =========================================================================
-- SECTION 4: GROUPING AND FILTERING GROUPS (GROUP BY & HAVING)
-- =========================================================================

-- TASK 11: Calculate the total number of trainees per province
SELECT 
    province, 
    COUNT(*) AS trainee_count 
FROM trainees 
GROUP BY province;

-- TASK 12: List provinces that have more than 1 trainee using HAVING
SELECT 
    province, 
    COUNT(*) AS trainee_count 
FROM trainees 
GROUP BY province 
HAVING COUNT(*) > 1;

-- STRETCH GOAL 3: Display facilitator full name and course count for those facilitating more than 1 course
SELECT 
    CONCAT(f.first_name, ' ', f.last_name) AS facilitator_name, 
    COUNT(c.course_id) AS course_count 
FROM facilitators f 
JOIN courses c ON f.facilitator_id = c.facilitator_id 
GROUP BY f.facilitator_id, f.first_name, f.last_name 
HAVING COUNT(c.course_id) > 1;