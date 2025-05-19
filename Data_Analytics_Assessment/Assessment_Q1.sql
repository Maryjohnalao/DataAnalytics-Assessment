-- Assessment_Q1.sql
-- Question 1: Identify customers who have both regular savings and investment accounts,
-- along with the count of each and total confirmed deposit amount.
-- Approach:
-- 1. Join users with savings accounts and plans.
-- 2. Filter accounts by plan types using is_regular_savings and is_a_fund flags.
-- 3. Count distinct savings and investment accounts per user.
-- 4. Sum confirmed deposit amounts (convert from kobo to base unit).
-- 5. Filter users with at least one savings and one investment account.
-- 6. Order by total deposits descending and limit to top user.

-- Question 1: Identify customers with both savings and investment accounts,
-- count number of accounts, and calculate total deposits.

SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    
    -- Count distinct savings accounts where plan is regular savings and confirmed deposit > 0
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 AND s.confirmed_amount > 0 THEN s.id END) AS savings_count,
    
    -- Count distinct investment accounts where plan is a fund and confirmed deposit > 0
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 AND s.confirmed_amount > 0 THEN s.id END) AS investment_count,
    
    -- Sum of all confirmed deposits in kobo converted to main currency by dividing by 100
    SUM(s.confirmed_amount) / 100.0 AS total_deposits
FROM users_customuser u
JOIN savings_savingsaccount s ON s.owner_id = u.id
JOIN plans_plan p ON p.id = s.plan_id
GROUP BY u.id, u.first_name, u.last_name
-- Only include customers with at least one savings and one investment account
HAVING savings_count > 0 AND investment_count > 0
ORDER BY total_deposits DESC
LIMIT 1;