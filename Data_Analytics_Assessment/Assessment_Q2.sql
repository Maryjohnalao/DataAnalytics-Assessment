-- Assessment_Q2.sql
-- Question 2: Analyze customer transaction frequency to segment them into
-- High, Medium, and Low frequency users based on average monthly transactions.
-- Approach:
-- 1. Calculate total transactions per user and the first and last transaction dates.
-- 2. Calculate tenure in months (avoid division by zero by forcing minimum of 1).
-- 3. Compute average transactions per month.
-- 4. Categorize frequency based on defined thresholds.
-- 5. Aggregate counts and average transactions per frequency category.

-- Step 1: Calculate each customer's total transactions and active months
WITH CustomerTransactions AS (
    SELECT
        s.owner_id,
        COUNT(*) AS total_transactions,
        -- Calculate number of distinct months with transactions for tenure approximation
        COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) AS active_months
    FROM savings_savingsaccount s
    GROUP BY s.owner_id
),

-- Step 2: Calculate average transactions per month per customer
AvgMonthlyTransactions AS (
    SELECT
        owner_id,
        total_transactions,
        active_months,
        CASE 
            WHEN active_months = 0 THEN 0 -- Avoid division by zero
            ELSE total_transactions / active_months
        END AS avg_transactions_per_month
    FROM CustomerTransactions
)

-- Step 3: Categorize customers by frequency and aggregate results
SELECT
    CASE
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM AvgMonthlyTransactions
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;