-- =====================================================
-- Setup: Create FeePayments table
-- =====================================================
DROP TABLE IF EXISTS FeePayments;

CREATE TABLE FeePayments (
    payment_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) CHECK (amount > 0),
    payment_date DATE NOT NULL
);

-- =====================================================
-- Part A: Insert Multiple Fee Payments in a Transaction
-- =====================================================
BEGIN;

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES
(1, 'Ashish', 5000.00, '2024-06-01'),
(2, 'Smaran', 4500.00, '2024-06-02'),
(3, 'Vaibhav', 5500.00, '2024-06-03');

COMMIT;

-- Verify inserts
SELECT 'Part A: After Commit' AS Stage;
SELECT * FROM FeePayments;

-- =====================================================
-- Part B: Demonstrate ROLLBACK for Failed Payment Insertion
-- =====================================================
BEGIN;

-- Valid insert
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (4, 'Kiran', 4000.00, '2024-06-04');

-- Invalid insert: duplicate payment_id & negative amount
-- This will fail due to PRIMARY KEY & CHECK constraint
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (1, 'Ashish', -1000.00, '2024-06-05');

-- Rollback on failure
ROLLBACK;

-- Verify state after rollback
SELECT 'Part B: After Rollback' AS Stage;
SELECT * FROM FeePayments;

-- =====================================================
-- Part C: Simulate Partial Failure and Ensure Consistent State
-- =====================================================
BEGIN;

-- Valid insert
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (5, 'Neha', 4700.00, '2024-06-06');

-- Invalid insert: NULL student_name violates NOT NULL
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (6, NULL, 4300.00, '2024-06-07');

-- Rollback on failure
ROLLBACK;

-- Verify state after rollback
SELECT 'Part C: After Partial Failure' AS Stage;
SELECT * FROM FeePayments;

-- =====================================================
-- Part D: Verify ACID Compliance with Transaction Flow
-- =====================================================

-- Session 1: Successful inserts
BEGIN;

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (7, 'Ravi', 5200.00, '2024-06-08');

INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (8, 'Tina', 4800.00, '2024-06-09');

COMMIT; -- Durability ensured

-- Session 2: Failed insert to demonstrate Isolation & Consistency
BEGIN;

-- Attempt duplicate ID
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (7, 'Ankit', 5000.00, '2024-06-10');

ROLLBACK; -- Ensures atomicity & consistency

-- Final table state
SELECT 'Part D: Final Table State (ACID Verified)' AS Stage;
SELECT * FROM FeePayments;
