CREATE TABLE dim_pharmacy(
PharmacyID TEXT PRIMARY KEY,
PharmacyName TEXT,
Country VARCHAR(50),
Region VARCHAR(100),
City VARCHAR(100),
PharmacyType VARCHAR(20),
OpenDate DATE,
StoreSizeBand TEXT,
Latitude DECIMAL (9,6),
Longitude DECIMAL (9,6)
)

CREATE TABLE dim_dates(
DateKey INT PRIMARY KEY,
Date DATE,
Year INT,
Quarter INT,
MonthNumber INT,
MonthName TEXT,
YearMonth TEXT	
)

CREATE TABLE sales(
SalesId TEXT PRIMARY KEY,
DateKey INT,
PharmacyID TEXT,
ProductId TEXT,
UnitsSold INT,
RevenueEUR DECIMAL,
CostEUR DECIMAL,
MarginEUR DECIMAL,
PromoFlag BOOLEAN
)
CREATE TABLE dim_product(
ProductID TEXT PRIMARY KEY,
ProductName TEXT,
Category TEXT,
Brand TEXT,
IsGeneric BOOLEAN,
PackSize TEXT,
ListPriceEUR DECIMAL (10,2),
StandardCostEUR DECIMAL (10,2),
LaunchDate DATE,
IsDiscontinued BOOLEAN,
DiscontinuedDate DATE
)


ALTER TABLE sales
ALTER COLUMN DateKey SET NOT NULL,
ALTER COLUMN ProductID SET NOT NULL,
ALTER COLUMN PharmacyID SET NOT NULL,
ALTER COLUMN UnitsSold SET NOT NULL,
ALTER COLUMN RevenueEUR SET NOT NULL,
ALTER COLUMN CostEUR SET NOT NULL,
ALTER COLUMN MarginEUR SET NOT NULL;

ALTER TABLE sales
ADD CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES dim_product(ProductID),
ADD CONSTRAINT fk_pharmacy FOREIGN KEY (PharmacyID) REFERENCES dim_pharmacy(PharmacyID),
ADD CONSTRAINT fk_date FOREIGN KEY (DateKey) REFERENCES dim_dates(DateKey);