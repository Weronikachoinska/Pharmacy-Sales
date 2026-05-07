-- =========================================
-- Overview
-- =========================================

--Revenue, Margin, Units Sold and Average Selling Price Over Time
SELECT 
    yearmonth,
    SUM(revenueEUR) AS total_revenue, 
    SUM(marginEUR) AS total_margin,
    ROUND(
        SUM(marginEUR)/SUM(revenueEUR) * 100.00
        ,2) AS margin_pct,
    SUM(unitsSold) AS units_sold,
    ROUND(
        AVG(revenueEUR /unitsSold)
        ,2) AS avg_selling_price
FROM sales s 
JOIN dim_dates d
    ON s.dateKey = d.dateKey
GROUP BY yearmonth
ORDER BY yearmonth

-- Revenue and Margin by Day of Week
SELECT 
    TO_CHAR(date, 'day') AS day_name,
    SUM(revenueEUR) AS total_revenue, 
    SUM(marginEUR) AS total_margin,
    ROUND(
        SUM(marginEUR)/SUM(revenueEUR) * 100.00
        ,2) AS margin_pct
FROM sales s 
JOIN dim_dates d
    ON s.dateKey = d.dateKey
GROUP BY TO_CHAR(date, 'day') 

--Revenue by Country
SELECT 
    country,
    SUM(revenueEUR) AS total_revenue
FROM sales s 
JOIN dim_pharmacy p
    ON s.pharmacyID = p.pharmacyID
GROUP BY country
ORDER BY total_revenue DESC

-- =========================================
-- Product
-- =========================================

--Revenue and Margin by Category
SELECT 
    category,
    SUM(revenueEUR) AS total_revenue, 
    SUM(marginEUR) AS total_margin,
    ROUND(
        SUM(marginEUR)/SUM(revenueEUR) * 100.00
        ,2) AS margin_pct
FROM sales s 
JOIN dim_product p
    ON s.productID = p.productID
GROUP BY category
ORDER BY total_revenue DESC

-- Top 5 Brands by Revenue
SELECT 
    brand,
    SUM(revenueEUR) AS total_revenue
FROM sales s 
JOIN dim_product p
    ON s.productID = p.productID
GROUP BY brand
ORDER BY total_revenue DESC
LIMIT 5

 --Bottom 5 Brands By Revenue 
SELECT 
    brand,
    SUM(revenueEUR) AS total_revenue
FROM sales s 
JOIN dim_product p
    ON s.productID = p.productID
GROUP BY brand
ORDER BY total_revenue 
LIMIT 5

--Promo Impact 
WITH promo_CTE AS(
    SELECT
        ROUND(
            SUM(CASE WHEN promoflag = TRUE THEN marginEUR END)
            /
            SUM(CASE WHEN promoflag = TRUE THEN revenueEUR END)
            * 100.00
            ,2) AS promo_margin_pct,
        ROUND(
            SUM(CASE WHEN promoflag = FALSE THEN marginEUR END)
            /
            SUM(CASE WHEN promoflag = FALSE THEN revenueEUR END)
            * 100.00
            ,2) AS no_promo_margin_pct,
        ROUND(
            SUM(CASE WHEN promoflag = TRUE THEN revenueEUR END)
            / SUM(revenueEUR)
            * 100.00
            ,2) promo_revenue
FROM sales
)
SELECT 
    promo_margin_pct,
    no_promo_margin_pct,
    promo_revenue,
    NO_promo_margin_pct - promo_margin_pct AS margin_difference
FROM promo_CTE

 --Revenue Generic vs Original
SELECT 
    isgeneric,
    SUM(revenueEUR) AS total_revenue,
    ROUND(
        SUM(revenueEUR) 
        / (SELECT SUM(revenueEUR) FROM sales)
        * 100.0
        ,2) AS revenue_pct
FROM sales s 
JOIN dim_product p
    ON s.productID = p.productID
GROUP BY isgeneric


-- =========================================
-- Market
-- =========================================

-- Revenue and Margin by City in Poland
SELECT 
    city,
    SUM(revenueEUR) AS total_revenue, 
    SUM(marginEUR) AS total_margin,
    ROUND(
        SUM(marginEUR)
        /SUM(revenueEUR) * 100.00
        ,2) AS margin_pct
FROM sales s 
JOIN dim_pharmacy p
    ON s.pharmacyID = p.pharmacyID
WHERE country = 'Poland'
GROUP BY city
ORDER BY total_revenue DESC

--Revenue and Margin by Pharmacy Type in Poland
SELECT 
    pharmacytype,
    SUM(revenueEUR) AS total_revenue, 
    SUM(marginEUR) AS total_margin,
    ROUND(
        SUM(marginEUR)
        /SUM(revenueEUR) * 100.00
        ,2) AS margin_pct
FROM sales s 
JOIN dim_pharmacy p
    ON s.pharmacyID = p.pharmacyID
WHERE country = 'Poland'
GROUP BY pharmacytype
ORDER BY total_revenue DESC

--Revenue by Store Size in Poland
SELECT 
    storesizeband,
    SUM(revenueEUR) AS total_revenue
FROM sales s
JOIN dim_pharmacy p
    ON s.pharmacyID = p.pharmacyID
WHERE country = 'Poland'
GROUP BY storesizeband
ORDER BY total_revenue DESC

 -- Top 5 Pharmacies in Poland By Revenue 
SELECT 
    pharmacyname,
    SUM(revenueEUR) AS total_revenue
FROM sales s 
JOIN dim_pharmacy p
    ON s.pharmacyID = p.pharmacyID
WHERE country = 'Poland'
GROUP BY pharmacyname
ORDER BY total_revenue DESC
LIMIT 5
