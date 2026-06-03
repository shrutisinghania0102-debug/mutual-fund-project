-- 1. Top 5 funds by AUM
SELECT amfi_code, SUM(amount) AS total_aum
FROM fact_transactions WHERE transaction_type != 'REDEMPTION'
GROUP BY amfi_code ORDER BY total_aum DESC LIMIT 5;

-- 2. Average NAV per month
SELECT amfi_code, strftime('%Y-%m', nav_date) AS month,
       AVG(nav) AS avg_nav
FROM fact_nav GROUP BY amfi_code, month;

-- 3. SIP inflow YoY growth
SELECT strftime('%Y', transaction_date) AS year,
       SUM(amount) AS sip_inflow
FROM fact_transactions WHERE transaction_type = 'SIP'
GROUP BY year ORDER BY year;

-- 4. Transactions by state
SELECT state, COUNT(*) AS txn_count, SUM(amount) AS total_amount
FROM fact_transactions GROUP BY state ORDER BY total_amount DESC;

-- 5. Funds with expense_ratio < 1%
SELECT d.scheme_name, p.expense_ratio
FROM fact_performance p JOIN dim_fund d ON p.amfi_code = d.amfi_code
WHERE p.expense_ratio < 1.0;