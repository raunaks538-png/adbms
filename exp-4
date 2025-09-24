DROP TABLE IF EXISTS FeePayments;

CREATE TABLE FeePayments (
    payment_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) CHECK (amount > 0),
    payment_date DATE NOT NULL
);

BEGIN TRANSACTION;

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (1, 'Ashish', 5000.00, '2024-06-01');

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (2, 'Smaran', 4500.00, '2024-06-02');

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (3, 'Vaibhav', 5500.00, '2024-06-03');

COMMIT;

SELECT * FROM FeePayments;

BEGIN TRANSACTION;

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (4, 'Kiran', 6000.00, '2024-06-04');

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (1, 'Ashish', -3000.00, '2024-06-05');

ROLLBACK;

SELECT * FROM FeePayments;

BEGIN TRANSACTION;

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (5, 'Mehul', 7000.00, '2024-06-06');

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (6, NULL, 6500.00, '2024-06-07');

ROLLBACK;

SELECT * FROM FeePayments;

BEGIN TRANSACTION;

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (7, 'Rohan', 8000.00, '2024-06-08');

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (2, 'Duplicate', 9000.00, '2024-06-09');

ROLLBACK;

SELECT * FROM FeePayments;




DROP TABLE IF EXISTS StudentEnrollments;

CREATE TABLE StudentEnrollments (
    enrollment_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL,
    CONSTRAINT uq_student_course UNIQUE (student_name, course_id)
);


BEGIN TRANSACTION;

INSERT INTO StudentEnrollments (enrollment_id, student_name, course_id, enrollment_date)
VALUES (1, 'Ashish', 'CSE101', '2024-07-01');

INSERT INTO StudentEnrollments (enrollment_id, student_name, course_id, enrollment_date)
VALUES (2, 'Smaran', 'CSE102', '2024-07-01');

INSERT INTO StudentEnrollments (enrollment_id, student_name, course_id, enrollment_date)
VALUES (3, 'Vaibhav', 'CSE101', '2024-07-01');

COMMIT;


BEGIN TRANSACTION;

INSERT INTO StudentEnrollments (enrollment_id, student_name, course_id, enrollment_date)
VALUES (4, 'Ashish', 'CSE101', '2024-07-02');

ROLLBACK;

SELECT * FROM StudentEnrollments;


START TRANSACTION;
SELECT * FROM StudentEnrollments
WHERE student_name = 'Ashish' AND course_id = 'CSE101'
FOR UPDATE;


COMMIT;


START TRANSACTION;
SELECT * FROM StudentEnrollments
WHERE student_name = 'Ashish' AND course_id = 'CSE101'
FOR UPDATE;

UPDATE StudentEnrollments
SET enrollment_date = '2024-07-15'
WHERE student_name = 'Ashish' AND course_id = 'CSE101';

COMMIT;
START TRANSACTION;
UPDATE StudentEnrollments
SET enrollment_date = '2024-07-20'
WHERE student_name = 'Ashish' AND course_id = 'CSE101';
COMMIT;


SELECT * FROM StudentEnrollments;

DROP TABLE IF EXISTS StudentEnrollments;

CREATE TABLE StudentEnrollments (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL
);

INSERT INTO StudentEnrollments (student_id, student_name, course_id, enrollment_date)
VALUES
(1, 'Ashish', 'CSE101', '2024-06-01'),
(2, 'Smaran', 'CSE102', '2024-06-01'),
(3, 'Vaibhav', 'CSE103', '2024-06-01');


START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-01' WHERE student_id = 1;

UPDATE StudentEnrollments SET enrollment_date = '2024-07-02' WHERE student_id = 2;


START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-05' WHERE student_id = 2;


UPDATE StudentEnrollments SET enrollment_date = '2024-07-06' WHERE student_id = 1;


START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT enrollment_date FROM StudentEnrollments WHERE student_id = 1;


START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-10' WHERE student_id = 1;
COMMIT;


COMMIT;

SELECT * FROM StudentEnrollments WHERE student_id = 1;


START TRANSACTION;
SELECT enrollment_date FROM StudentEnrollments WHERE student_id = 1 FOR UPDATE;


UPDATE StudentEnrollments SET enrollment_date = '2024-07-15' WHERE student_id = 1;


START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT enrollment_date FROM StudentEnrollments WHERE student_id = 1;


UPDATE StudentEnrollments SET enrollment_date = '2024-07-20' WHERE student_id = 1;
COMMIT;



SELECT * FROM StudentEnrollments WHERE student_id = 1;
