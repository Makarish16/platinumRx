
-- ---------------------------------------------------------
-- Q1. Find the revenue we got from each sales channel in a given year
-- ---------------------------------------------------------
SELECT 
    sales_channel, 
    SUM(amount) as total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

-- ---------------------------------------------------------
-- Q2. Find top 10 most valuable customers for a given year
-- ---------------------------------------------------------
SELECT 
    c.name, 
    SUM(s.amount) as total_spend
FROM clinic_sales s
JOIN customer c ON s.uid = c.uid
WHERE YEAR(s.datetime) = 2021
GROUP BY c.name, c.uid
ORDER BY total_spend DESC
LIMIT 10;

-- ---------------------------------------------------------
-- Q3. Find month wise revenue, expense, profit, status (profitable / not-profitable) for a given year
-- ---------------------------------------------------------
WITH MonthlySales AS (
    SELECT MONTH(datetime) as mth, SUM(amount) as revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
MonthlyExp AS (
    SELECT MONTH(datetime) as mth, SUM(amount) as expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT 
    s.mth,
    s.revenue,
    COALESCE(e.expense, 0) as expense,
    (s.revenue - COALESCE(e.expense, 0)) as profit,
    CASE 
        WHEN (s.revenue - COALESCE(e.expense, 0)) > 0 THEN 'Profitable'
        ELSE 'Not-Profitable'
    END as status
FROM MonthlySales s
LEFT JOIN MonthlyExp e ON s.mth = e.mth;

-- ---------------------------------------------------------
-- Q4. For each city find the most profitable clinic for a given month (e.g., Month 9 - September)
-- ---------------------------------------------------------
WITH ClinicStats AS (
    SELECT 
        c.city,
        c.clinic_name,
        -- Calculate Profit: (Total Sales for Clinic) - (Total Expenses for Clinic)
        (
            COALESCE((SELECT SUM(s.amount) FROM clinic_sales s WHERE s.cid = c.cid AND MONTH(s.datetime) = 9 AND YEAR(s.datetime)=2021), 0) 
            - 
            COALESCE((SELECT SUM(e.amount) FROM expenses e WHERE e.cid = c.cid AND MONTH(e.datetime) = 9 AND YEAR(e.datetime)=2021), 0)
        ) as profit
    FROM clinics c
),
RankedClinics AS (
    SELECT 
        city, 
        clinic_name, 
        profit,
        RANK() OVER(PARTITION BY city ORDER BY profit DESC) as rnk
    FROM ClinicStats
)
SELECT city, clinic_name, profit
FROM RankedClinics
WHERE rnk = 1;

-- ---------------------------------------------------------
-- Q5. For each state find the second least profitable clinic for a given month
-- ---------------------------------------------------------
WITH ClinicStats AS (
    SELECT 
        c.state,
        c.clinic_name,
        (
            COALESCE((SELECT SUM(s.amount) FROM clinic_sales s WHERE s.cid = c.cid AND MONTH(s.datetime) = 9 AND YEAR(s.datetime)=2021), 0) 
            - 
            COALESCE((SELECT SUM(e.amount) FROM expenses e WHERE e.cid = c.cid AND MONTH(e.datetime) = 9 AND YEAR(e.datetime)=2021), 0)
        ) as profit
    FROM clinics c
),
RankedClinics AS (
    SELECT 
        state, 
        clinic_name, 
        profit,
        -- Order by Profit ASC (Ascending) to find the least profitable first
        DENSE_RANK() OVER(PARTITION BY state ORDER BY profit ASC) as rnk
    FROM ClinicStats
)
-- We select rank 2 to get the "Second Least"
SELECT state, clinic_name, profit
FROM RankedClinics
WHERE rnk = 2;
