-- 1. Top 5 funds by AUM

SELECT amfi_code,
aum_crore
FROM fact_performance
ORDER BY aum_crore DESC
LIMIT 5;

-- 2. Average NAV per month

SELECT strftime('%Y-%m', date) AS month,
AVG(nav) AS avg_nav
FROM fact_nav
GROUP BY month
ORDER BY month;

-- 3. SIP inflow YoY growth

SELECT strftime('%Y', transaction_date) AS year,
SUM(amount_inr) AS total_sip
FROM fact_transactions
WHERE transaction_type='SIP'
GROUP BY year
ORDER BY year;

-- 4. Transactions by state

SELECT state,
COUNT(*) AS transactions
FROM fact_transactions
GROUP BY state
ORDER BY transactions DESC;

-- 5. Funds with expense ratio < 1%

SELECT amfi_code,
scheme_name,
expense_ratio_pct
FROM dim_fund
WHERE expense_ratio_pct < 1;

-- 6. Top 10 funds by 1-year return

SELECT amfi_code,
return_1yr_pct
FROM fact_performance
ORDER BY return_1yr_pct DESC
LIMIT 10;

-- 7. Average expense ratio by category

SELECT category,
AVG(expense_ratio_pct) AS avg_expense
FROM dim_fund
GROUP BY category;

-- 8. Average Sharpe ratio by risk category

SELECT risk_grade,
AVG(sharpe_ratio) AS avg_sharpe
FROM fact_performance
GROUP BY risk_grade;

-- 9. Total AUM by fund house

SELECT fund_house,
SUM(aum_crore) AS total_aum
FROM fact_aum
GROUP BY fund_house
ORDER BY total_aum DESC;

-- 10. Funds count according to risk category

SELECT risk_category,
       COUNT(*) AS fund_count
FROM dim_fund
GROUP BY risk_category
ORDER BY fund_count DESC;
