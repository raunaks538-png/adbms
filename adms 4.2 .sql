-- =====================================================
-- Setup: Create StudentEnrollments Table
-- =====================================================
DROP TABLE IF EXISTS StudentEnrollments;

CREATE TABLE StudentEnrollments (
    enrollment_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL,
    CONSTRAINT unique_student_course UNIQUE(student_name, course_id)
);

-- Insert initial data
INSERT INTO StudentEnrollments (enrollment_id, student_name, course_id, enrollment_date)
VALUES
(1, 'Ashish', 'CSE101', '2024-07-01'),
(2, 'Smaran', 'CSE102', '2024-07-01'),
(3, 'Vaibhav', 'CSE101', '2024-07-01');

-- Verify initial state
SELECT 'Initial Table State' AS Stage;
SELECT * FROM StudentEnrollments;

-- =====================================================
-- Part A: Prevent Duplicate Enrollments
-- =====================================================
BEGIN;

-- Attempt duplicate enrollment for Ashish in CSE101
-- This should fail due to UNIQUE constraint
INSERT INTO StudentEnrollments (enrollment_id, student_name, course_id, enrollment_date)
VALUES (4, 'Ashish', 'CSE101', '2024-07-02');

-- If error occurs, rollback
ROLLBACK;

-- Verify table state after Part A
SELECT 'Part A: After Attempting Duplicate Enrollment' AS Stage;
SELECT * FROM StudentEnrollments;

-- =====================================================
-- Part B: Use SELECT FOR UPDATE to Lock Student Record
-- =====================================================
-- Simulation: User A locks a row
-- (In a real concurrent test, use two sessions/terminals)

-- User A Transaction
BEGIN;

-- Lock Ashish's CSE101 row
SELECT * FROM StudentEnrollments
WHERE student_name = 'Ashish' AND course_id = 'CSE101'
FOR UPDATE;

-- (Do not commit yet; row is locked)

-- -- Simulate User B trying to update the same row
-- In another session:
-- BEGIN;
-- UPDATE StudentEnrollments
-- SET enrollment_date = '2024-07-10'
-- WHERE student_name = 'Ashish' AND course_id = 'CSE101';
-- -- This will be blocked until User A commits or rollbacks

-- Commit User A to release lock
COMMIT;

-- Verify table state after Part B
SELECT 'Part B: After Locking and Commit' AS Stage;
SELECT * FROM StudentEnrollments;

-- =====================================================
-- Part C: Demonstrate Locking Preserving Consistency
-- =====================================================

-- Simulation of sequential updates with row-level locks

-- User A starts transaction
BEGIN;

-- Lock row for Ashish in CSE101
SELECT * FROM StudentEnrollments
WHERE enrollment_id = 1
FOR UPDATE;

-- Update enrollment_date
UPDATE StudentEnrollments
SET enrollment_date = '2024-07-05'
WHERE enrollment_id = 1;

-- Commit User A
COMMIT;

-- User B starts transaction (after User A committed)
BEGIN;

-- Lock same row
SELECT * FROM StudentEnrollments
WHERE enrollment_id = 1
FOR UPDATE;

-- Update enrollment_date
UPDATE StudentEnrollments
SET enrollment_date = '2024-07-06'
WHERE enrollment_id = 1;

-- Commit User B
COMMIT;

-- Final table state
SELECT 'Part C: Final Table State after Sequential Updates with Locking' AS Stage;
SELECT * FROM StudentEnrollments;
