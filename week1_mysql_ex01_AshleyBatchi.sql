-- =========================================================================
-- COURSE 2 – BACKEND WEB DEVELOPMENT: EXERCISE 01
-- TOPIC: DATABASE DESIGN AND TABLE CREATION (3NF NORMALISATION)
-- STUDENT FILE: week1_mysql_ex01_AshleyBatchi.sql
-- TARGET INSTANCE: PORT 3307
-- =========================================================================

-- TASK 1: Create the new database cluster if it doesn't exist
CREATE DATABASE IF NOT EXISTS edutrack_sa;
USE edutrack_sa;


-- TASK 2: Create the 'facilitators' data matrix (1st Table)
-- Normalised to 3NF: No transitive/partial dependencies present.
CREATE TABLE IF NOT EXISTS facilitators (
    facilitator_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    PRIMARY KEY (facilitator_id),
    CONSTRAINT unique_facilitator_email UNIQUE (email)
);


-- TASK 3: Create the 'courses' data matrix (2nd Table)
-- Enforces a Foreign Key dependency tracking to the primary facilitators map.
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    duration_weeks INT NOT NULL,
    facilitator_id INT,
    PRIMARY KEY (course_id),
    FOREIGN KEY (facilitator_id) REFERENCES facilitators(facilitator_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


-- TASK 4: Create the 'trainees' data matrix (3rd Table)
-- Includes optional Stretch Goal: created_at TIMESTAMP tracking.
CREATE TABLE IF NOT EXISTS trainees (
    trainee_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    province VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (trainee_id),
    CONSTRAINT unique_trainee_email UNIQUE (email)
);


-- TASK 5: Create the relational 'enrolments' mapping junction (4th Table)
-- Includes structural Stretch Goals: status CHECK constraint and live TIMESTAMP tracking.
CREATE TABLE IF NOT EXISTS enrolments (
    enrolment_id INT AUTO_INCREMENT,
    trainee_id INT NOT NULL,
    course_id INT NOT NULL,
    enrolment_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (enrolment_id),
    FOREIGN KEY (trainee_id) REFERENCES trainees(trainee_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    CONSTRAINT check_enrolment_status CHECK (status IN ('Active', 'Completed', 'Withdrawn'))
);


-- =========================================================================
-- DATA INGESTION: SEEDING REALISTIC SOUTH AFRICAN REGISTRY RECORDS
-- =========================================================================

-- TASK 6: Populate the 'facilitators' catalog records
INSERT INTO facilitators (first_name, last_name, email, phone) VALUES
('Sipho', 'Modise', 'sipho.modise@edutrack.co.za', '+27821112223'),
('Chantel', 'van Wyk', 'chantel.vanwyk@edutrack.co.za', '+27834445556'),
('Thabo', 'Mokoena', 'thabo.mokoena@edutrack.co.za', '+27717778889'),
('Lindiwe', 'Nkosi', 'lindiwe.nkosi@edutrack.co.za', '+27629990001');


-- TASK 7: Populate the 'courses' catalog records
INSERT INTO courses (course_name, duration_weeks, facilitator_id) VALUES
('Introduction to Database Design & Normalisation', 12, 1),
('Advanced Vue.js Enterprise Frameworks', 8, 2),
('Full-Stack Node.js Web Architecture', 16, 3),
('Responsive UI Design with Bootstrap & Tailwind', 6, 4);


-- TASK 8: Populate the 'trainees' database map
INSERT INTO trainees (first_name, last_name, email, province) VALUES
('Ashley', 'Batchi', 'ashley.batchi@student.co.za', 'Western Cape'),
('Zama', 'Khumalo', 'zama.khumalo@student.co.za', 'Gauteng'),
('Anathi', 'Ncube', 'anathi.ncube@student.co.za', 'KwaZulu-Natal'),
('Brandon', 'Pieterse', 'brandon.p@student.co.za', 'Gauteng');


-- TASK 9: Populate the operational 'enrolments' link matrix
INSERT INTO enrolments (trainee_id, course_id, enrolment_date, status) VALUES
(1, 1, '2026-07-15', 'Active'),
(2, 2, '2026-07-10', 'Completed'),
(3, 3, '2026-07-12', 'Active'),
(4, 1, '2026-07-14', 'Withdrawn');


-- =========================================================================
-- DATA VERIFICATION & EXTRACTION QUERIES
-- =========================================================================

-- TASK 10: Standard verification queries confirming clean table creation
SELECT * FROM facilitators;
SELECT * FROM courses;
SELECT * FROM trainees;
SELECT * FROM enrolments;


-- TASK 11: Stretch Goal Target Query (Filters full name and province for Gauteng only)
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    province 
FROM trainees 
WHERE province = 'Gauteng';