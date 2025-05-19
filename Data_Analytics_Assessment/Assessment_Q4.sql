-- Assessment_Q4.sql
-- Question 4: Estimate Customer Lifetime Value (CLV) based on tenure and transaction volume.
-- Approach:
-- 1. Calculate customer tenure in months from date_joined to current date.
-- 2. Count total transactions from savings accounts per customer.
-- 3. Calculate average profit per transaction as 0.1% of average confirmed amount.
-- 4. Compute estimated CLV using the simplified formula:
--    CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction
-- 5. Order customers by estimated CLV descending.

-- Question 4: Customer Lifetime Value (CLV) estimation

SELECT
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    -- CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction
    -- avg_profit_per_transaction = 0.1% of average transaction value (confirmed_amount)
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE), 0)) * 12 *
        (AVG(s.confirmed_amount) * 0.001), 2
    ) AS estimated_clv
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON s.owner_id = u.id
GROUP BY u.id, u.first_name, u.last_name, u.date_joined
HAVING tenure_months > 0
ORDER BY estimated_clv DESC;