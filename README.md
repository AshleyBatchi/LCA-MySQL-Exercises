# LCA MySQL Exercises

**Trainee:** Ashley Batchi
**Database:** edutrack_sa

## Exercise 03 - SQL Joins and Data Manipulation
This branch contains queries demonstrating cross-table relational joins and database updates.

### Schema Overview
* **facilitators:** Instructor details (ID, name, email, phone).
* **courses:** Course offerings linked to facilitators.
* **trainees:** Student records including their home province.
* **enrolments:** Junction table tracking student statuses in various courses.

### Queries Written
1. **INNER JOINS:** Linked enrolments, trainees, and courses to generate class lists. Paired courses with their facilitators.
2. **OUTER JOINS:** Used LEFT and RIGHT joins to identify unassigned courses and unenrolled trainees.
3. **DML Statements:** Updated student provinces and enrolment statuses securely. Deleted a withdrawn record using strict ORDER BY and LIMIT constraints.
4. **Advanced Queries:** Grouped active enrolments and calculated the facilitator with the highest student volume.