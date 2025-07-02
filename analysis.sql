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

-- 2. Deteksi Anomali berdasarkan decoy_noise
-- ==============================
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