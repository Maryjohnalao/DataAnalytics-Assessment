# DataAnalytics-Assessment

## Overview

This repository contains my solutions to the SQL proficiency assessment designed to evaluate my skills in querying and analyzing relational databases.
The assessment involved working with tables related to users, savings accounts, plans, and withdrawals, with a focus on data retrieval, aggregation, and filtering to solve real-world business questions.


## Repository Structure

DataAnalytics-Assessment/
│
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md


Each .sql file includes a single, well-structured SQL query that answers the respective question, accompanied by detailed comments explaining the logic.



## Challenges Encountered & How They Were Addressed

### 1. Schema Understanding and Column Verification

Initially, there was some ambiguity about the exact column names and table relationships, which is common when working with new datasets. To resolve this:

- I examined the database schema carefully, verifying column names and data types using SHOW TABLES and DESCRIBE commands.
- Ensured foreign key relationships (e.g., owner_id linking to user id) were correctly interpreted to join tables accurately.

### 2. Handling Multiple Date Fields for Filtering

The dataset contained multiple date columns such as created_on, transaction_date, and others across different tables. This required:

- Choosing the appropriate date fields consistently for filtering transactions and account creation.
- Using DATE() or DATE_FORMAT() functions carefully to standardize date comparisons.
- Adjusting queries where initial filters caused errors or unexpected results, ensuring correct syntax and logic.

### 3. Managing NULLs and Missing Data in Joins

When querying data involving outer joins, some rows had NULLs (e.g., plans with no recent transactions). This was addressed by:

- Using LEFT JOIN and handling NULL values in WHERE or HAVING clauses properly.
- Applying conditional checks to include or exclude records based on presence or absence of related transactions.

### 4. Ensuring Accurate Aggregation and Filtering

Some queries returned multiple rows where a single summary was expected. To fix this:

- Used aggregation functions like SUM(), MAX(), and GROUP BY with appropriate filters.
- Applied HAVING clauses to enforce conditions on grouped data.
- Validated outputs by comparing results with expected output formats.

### 5. Data Unit Conversion

Amounts were stored in kobo (minor currency units), while the output required main currency units. I consistently:

- Divided amount fields by 100 to convert kobo to naira/dollars as needed.
- Added comments in the SQL queries to clarify these conversions.


## Summary of Approach

- Carefully joined related tables using verified foreign key relationships.
- Applied filtering to select active and relevant records (e.g., non-deleted, non-archived plans).
- Aggregated transaction values and performed date-based calculations for insights.
- Maintained readability and clarity by adding comments explaining complex parts.
- Iteratively tested and refined queries to meet expected output formats.


## Final Thoughts

This assessment provided a valuable opportunity to work through realistic data challenges, including interpreting unfamiliar schemas, handling inconsistent data, and writing optimized queries for clear business insights.

I approached each problem methodically, verifying assumptions, testing queries incrementally, and documenting my reasoning. I am confident the solutions presented here demonstrate proficiency in SQL querying and data analysis aligned with the assessment requirements.


Thank you for considering my submission.

Prepared by Anuoluwapo Oluwayemisi Alao
Date: 19th of May, 2025