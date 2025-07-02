CREATE DATABASE ds_takehome;

SELECT * FROM e_commerce_transactions;

-- 1A. Menghitung RFM (Recency, Frequency, Monetary)
-- =================================================
WITH rfm_base AS (
  SELECT
    customer_id,
    MAX(STR_TO_DATE(order_date, '%Y-%m-%d')) AS recency_date,
    COUNT(order_id) AS frequency,
    SUM(payment_value) AS monetary
  FROM e_commerce_transactions
  GROUP BY customer_id
),

rfm_table AS (
  SELECT *,
    DATEDIFF('2025-05-06', recency_date) AS recency
  FROM rfm_base
)

SELECT * FROM rfm_table;

-- ==============================
-- 1B. Membuat 6 segmen pelanggan
-- ==============================
WITH rfm_base AS (
  SELECT
    customer_id,
    MAX(STR_TO_DATE(order_date, '%Y-%m-%d')) AS recency_date,
    COUNT(order_id) AS frequency,
    SUM(payment_value) AS monetary
  FROM e_commerce_transactions
  GROUP BY customer_id
),

rfm_table AS (
  SELECT *,
    DATEDIFF('2025-05-06', recency_date) AS recency
  FROM rfm_base
)

SELECT *,
  CASE
    WHEN frequency >= 18 AND monetary >= 4000 THEN 'Champions'
    WHEN frequency >= 10 AND monetary >= 2000 THEN 'Loyal Customers'
    WHEN frequency >= 5 AND monetary >= 1000 THEN 'Potential Loyalists'
    WHEN frequency >= 2 AND recency > 60 THEN 'At Risk'
    WHEN frequency <= 3 AND monetary < 500 AND recency > 90 THEN 'Lost'
    ELSE 'Others'
  END AS segment
FROM rfm_table
ORDER BY segment;

-- ==========================================
-- 2. Deteksi Anomali berdasarkan decoy_noise
-- ==========================================
SELECT
  order_id,
  customer_id,
  payment_value,
  decoy_flag,
  decoy_noise,
  ABS(payment_value - decoy_noise) AS gap
FROM
  e_commerce_transactions
WHERE
  ABS(payment_value - decoy_noise) > 150
ORDER BY
  gap DESC;
  
-- ====================================
-- 3. Repeat-purchase bulanan + EXPLAIN
-- ====================================

-- 3.1 Menambahkan kolom bulan (format YYYY-MM)
WITH orders_with_month AS (
  SELECT
    customer_id,
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id) AS order_count
  FROM
    e_commerce_transactions
  GROUP BY
    customer_id, order_month
),

-- 3.2 Mengambil yang belanja lebih dari 1x di bulan yang sama
repeat_purchase AS (
  SELECT *
  FROM orders_with_month
  WHERE order_count > 1
)

-- 3.3 Menghitung jumlah repeat-purchase per bulan
SELECT
  order_month,
  COUNT(DISTINCT customer_id) AS repeat_customers
FROM
  repeat_purchase
GROUP BY
  order_month
ORDER BY
  order_month;

-- Melihat rencana eksekusi query (EXPLAIN)
EXPLAIN
SELECT
  order_month,
  COUNT(DISTINCT customer_id)
FROM
  (
    SELECT
      customer_id,
      DATE_FORMAT(order_date, '%Y-%m') AS order_month,
      COUNT(order_id) AS order_count
    FROM e_commerce_transactions
    GROUP BY customer_id, DATE_FORMAT(order_date, '%Y-%m')
    HAVING order_count > 1
  ) AS subquery
GROUP BY order_month;