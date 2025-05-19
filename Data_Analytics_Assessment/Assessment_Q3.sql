-- Assessment_Q3.sql
-- Question 3: Find active accounts (savings or investment) with no transactions in the last 365 days.
-- Approach:
-- 1. Filter active plans (not deleted or archived).
-- 2. Left join savings accounts to find last transaction dates per plan.
-- 3. Calculate days since last transaction and filter those inactive for >= 365 days.
-- 4. Identify plan type based on flags.

-- Question 3: Find active accounts with no transactions in the last 365 days (1 year)

WITH LastTransaction AS (
    SELECT
        p.id AS plan_id,
        p.owner_id,
        CASE
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        MAX(s.transaction_date) AS last_transaction_date
    FROM plans_plan p
    LEFT JOIN savings_savingsaccount s ON s.plan_id = p.id
    WHERE p.is_deleted = 0 AND p.is_archived = 0 -- Active plans only
    GROUP BY p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
)

SELECT
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURRENT_DATE, last_transaction_date) AS inactivity_days
FROM LastTransaction
WHERE last_transaction_date <= DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
ORDER BY inactivity_days DESC;