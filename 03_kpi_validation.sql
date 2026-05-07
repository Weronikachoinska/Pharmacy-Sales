-- =========================================
-- Validate KPI displayed in Power BI dashboard
-- =========================================

-- =========================================
-- OVERALL KPI VALIDATION
-- =========================================
SELECT 
	SUM(revenueEUR) AS total_revenue, 
	SUM(costEUR) AS total_cost, 
	SUM(UnitsSold) AS total_units_sold,
	SUM(marginEUR) AS total_margin 
FROM sales 

-- =========================================
-- FILTER VALIDATION
-- =========================================
SELECT 
SUM(revenueeur) AS total_revenue, 
SUM(costeur) AS total_cost, 
SUM(UnitsSold) AS total_units_sold,
SUM(margineur) AS total_margin 
FROM sales s 
JOIN dim_pharmacy p  
ON s.pharmacyid = p.pharmacyid
WHERE country = 'Poland'

-- =========================================
-- MONTH-OVER-MONTH VALIDATION
-- =========================================
WITH total_revenue_cte AS ( 
	SELECT  
		yearmonth, 
		SUM(revenueEUR) AS current_revenue 
	FROM sales s 
	JOIN dim_dates d 
		ON s.dateKey = d.dateKey 
	GROUP BY yearmonth 
), previous_cte AS( 
	SELECT 
		yearmonth,  
		current_revenue, 
		LAG(current_revenue) OVER(ORDER BY yearmonth) AS previous_mth_revenue 
	FROM total_revenue_cte 
) 
SELECT 
	yearmonth, 
	current_revenue, 
	(current_revenue - previous_mth_revenue) AS revenue_diff,
	ROUND( 
		(current_revenue - previous_mth_revenue) * 100.00 
		/NULLIF(previous_mth_revenue, 0)
		,2) AS pct_revenue_diff 
FROM previous_cte 