-- =========================================
-- DATA QUALITY CHECKS
-- =========================================


-- =========================================
-- CHECKING ANOMALIES
-- =========================================

-- Revenue lower than cost
SELECT COUNT(*) As invalid_revenue_vs_cost
FROM sales
WHERE RevenueEUR < CostEUR;

--Negative Margin
SELECT COUNT(*) AS negative_margin
FROM sales
WHERE marginEUR < 0;

--Negative Revenue
SELECT COUNT(*) AS negative_revenue
FROM sales
WHERE revenueEUR < 0;

--Negative Cost
SELECT COUNT(*) AS negative_cost
FROM sales
WHERE costEUR < 0;

--Negative Units Sold
SELECT COUNT(*) AS negative_units_sold
FROM sales 
WHERE UnitsSold < 0;

 --Margin validation
SELECT COUNT(*) As invalid_margin_calculation
FROM sales
WHERE MarginEUR != (RevenueEUR - CostEUR);

-- =========================================
-- CHECKING DUPLICATES
-- =========================================

SELECT COUNT(*) AS duplicate_sales_ids
FROM (
    SELECT SalesID
    FROM sales
    GROUP BY SalesID
    HAVING COUNT(*) > 1
) duplicates;

-- =========================================
-- CHECKING NULL VALUES
-- ========================================

SELECT COUNT(*) AS null_units_sold
FROM sales 
WHERE Unitssold IS NULL;

-- =========================================
-- CHECKING RELATIONSHIPS
-- =========================================

-- Missing products

SELECT *
FROM sales s
LEFT JOIN dim_product p 
    ON s.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

 --Missing pharmacies
SELECT *
FROM sales s
LEFT JOIN dim_pharmacy p 
    ON s.PharmacyID = p.PharmacyID
WHERE p.PharmacyID IS NULL;

 --Missing dates
SELECT *
FROM sales s
LEFT JOIN dim_dates d 
    ON s.DateKey = d.DateKey
WHERE d.DateKey IS NULL;