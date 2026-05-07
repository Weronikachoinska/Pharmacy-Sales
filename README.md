# Pharmacy Sales Analysis
## Table of Contents

- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Tools & Technologies](#tools--technologies)
- [Methodology](#methodology)
- [Key Insights](#key-insights)
- [Business Recommendations](#business-recommendations)
- [Limitations](#limitations)
- [How to Run](#-how-to-run)
  
## Project overview
This project analyzes pharmacy sales performance across multiple contries, cities, product categories and pharmacy types using Power BI.

**The dashobard focuses on:**
-revenue and margin analysis over time
-units sold and average selling price analysis over time
-promotion performance
-brands and products performance
-country and city-level comparision
-performance od different types of pharmacy


## Dataset

The dataset was sourced from [Kaggle](https://www.kaggle.com/datasets/ehmadali/eu-pharmacy-products-and-pricing).
The original data was provided in Excel format and converted to SQL database.
Due to file size limitations, the raw dataset is not included in this repository.

The dataset follows a classic star schema with 1 fact table and 3 dimension tables:
FactSales → 62,139 rows (Fact Table)
├── DimDate → 731 rows (Date Dimension)
├── DimPharmacy → 120 rows (Store Dimension)
└── DimProduct → 220 rows (Product Dimension)
### Data Model
![1](screenshots/data_model.png)



## Tools & Technologies

This project combines SQL and Power BI.
SQL was applied for data cleaning and validation, whereas PowerBi was used for making interavtive dashboard.


### Tools:
- SQL (PostgreSQL)
- PowerBI Desktop

## Methodology

The analysis included:
- Data cleaning and preprocessing (handling missing values, cancelled invoices, negative quantities)
- Statistical analysis
- SQL-based aggregation (top countries, products, customers)
- Time-series analysis (monthly revenue, YoY growth, seasonality)
- Customer behavior analysis (order frequency distribution)
- Revenue contribution analysis
- Correlation analysis (Price vs Sales Volume – Pearson & Spearman)

 ## Key insights
 
- Revenue is driven by a few key countries, namely Germany, France, Italy and Belgium.
- Revenue remains relatively stable over time, while profit margins fluctuate significantly between periods.
- Weekend sales performance is weaker than weekdays.
- There is no clear relationship between units sold and price.
- Prescription products generate the highest revenue, while Wellness and Personal Care categories achieve higher profit margins.
- Promotional sales account for a relatively small share of revenue and are associated with approximately 9 percentage points lower margins.
- Original branded products dominate total revenue, while generic products contribute a smaller market share.
- Large and urban pharmacies generally outperform smaller and rural locations in both revenue and margin performance.			


## Example visualization

### Monthly revenue overtime
![1](screenshots/Monthly_revenue_over_time.png)

### Monthly Year-over-Year Revenue Growth
![2](screenshots/Year_over_Year.png)

### Top 10 Customers Revenue Contribution
![3](screenshots/Revenue_contribution.png)

### Distribution of Number of Orders per Customer
![4](screenshots/Orders_distribution.png)

## Business Recommendations
- Optimize promotional strategies to improve both revenue contribution and margin performance from promotional sales.
- Increase focus on high-margin categories such as Wellness and Personal Care to improve overall profitability.
- Consider targeted weekend campaigns to increase weekend sales performance
- Investigate the reason behind the significantly lower performance of rural and smaller pharmacies and expand successful practices used by large and urban pharmacies where possible.

