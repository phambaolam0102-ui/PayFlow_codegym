-- =============================================
-- PAYFLOW DATABASE PERFORMANCE OPTIMIZATION
-- =============================================

DROP DATABASE IF EXISTS payflow_db;

CREATE DATABASE payflow_db;

USE payflow_db;


-- =============================================
-- 1. TẠO BẢNG TRANSACTIONS
-- =============================================

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);


-- =============================================
-- 2. DỮ LIỆU THỬ NGHIỆM
-- =============================================

INSERT INTO Transactions
(user_id, amount, transaction_type, created_at)
VALUES
(1, 100000, 'DEPOSIT', '2026-06-01 08:00:00'),
(2, 200000, 'DEPOSIT', '2026-06-03 09:15:00'),
(3, 50000, 'WITHDRAW', '2026-06-05 10:00:00'),
(4, 350000, 'DEPOSIT', '2026-06-10 11:30:00'),
(5, 150000, 'TRANSFER', '2026-06-12 12:00:00'),
(6, 400000, 'DEPOSIT', '2026-06-20 14:20:00'),
(7, 100000, 'WITHDRAW', '2026-06-25 15:00:00'),
(8, 500000, 'DEPOSIT', '2026-06-30 16:00:00'),
(9, 250000, 'DEPOSIT', '2026-07-01 08:00:00'),
(10, 300000, 'DEPOSIT', '2026-05-20 09:00:00');


-- =============================================
-- 3. EXPLAIN TRUY VẤN CŨ
-- NON-SARGABLE
-- =============================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;


-- =============================================
-- 4. TẠO COMPOSITE INDEX
-- =============================================

CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);


-- =============================================
-- 5. KIỂM TRA INDEX
-- =============================================

SHOW INDEX FROM Transactions;


-- =============================================
-- 6. EXPLAIN TRUY VẤN ĐÃ TỐI ƯU
-- SARGABLE
-- =============================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';


-- =============================================
-- 7. CHẠY TRUY VẤN THỰC TẾ
-- =============================================

SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';