--1.Which products are most/ least popular either instore or online and how does popularity impact revenue/cost of the products?
SELECT 
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    SUM(sod.LineTotal) AS TotalRevenue,
    (SELECT AVG(pch.StandardCost)
     FROM Production.ProductCostHistory pch
     WHERE pch.ProductID = p.ProductID) AS AvgCost,
    (SUM(sod.LineTotal) - 
     (SUM(sod.OrderQty) * 
      (SELECT AVG(pch.StandardCost)
       FROM Production.ProductCostHistory pch
       WHERE pch.ProductID = p.ProductID))) AS Profit
FROM 
    Sales.SalesOrderDetail sod
INNER JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY 
    p.ProductID, p.Name
ORDER BY 
    TotalQuantitySold DESC;  -- For most popular products
-- Use ASC for least popular products

--2.Which products are most/ least profitable either instore or online and how does profitability impact revenue/cost of the products?
SELECT 
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    SUM(sod.LineTotal) AS TotalRevenue,
    (SELECT AVG(pch.StandardCost)
     FROM Production.ProductCostHistory pch
     WHERE pch.ProductID = p.ProductID) AS AvgCost,
    (SUM(sod.LineTotal) - 
     (SUM(sod.OrderQty) * 
      (SELECT AVG(pch.StandardCost)
       FROM Production.ProductCostHistory pch
       WHERE pch.ProductID = p.ProductID))) AS Profit
FROM 
    Sales.SalesOrderDetail sod
INNER JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY 
    p.ProductID, p.Name
ORDER BY 
    Profit DESC;  -- For most profitable products
-- Use ASC for least profitable products


--3.Which products would your team recommend to AW to target with sales and marketing promotions and why?
-- High-Profit, Moderate-Sales Volume Products
SELECT 
    p.Name AS ProductName,              
    SUM(sod.OrderQty) AS TotalQuantitySold, 
    SUM(sod.LineTotal) AS TotalRevenue,  
    AVG(pch.StandardCost) AS AvgCost,    
    (SUM(sod.LineTotal) - 
     (SUM(sod.OrderQty) * AVG(pch.StandardCost))) AS Profit,  
    (SUM(sod.LineTotal) - 
     (SUM(sod.OrderQty) * AVG(pch.StandardCost))) / SUM(sod.OrderQty) AS ProfitPerUnit 
FROM 
    Sales.SalesOrderDetail sod
INNER JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN 
    Production.ProductCostHistory pch ON p.ProductID = pch.ProductID
INNER JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY 
    p.ProductID, p.Name
HAVING 
    (SUM(sod.LineTotal) - (SUM(sod.OrderQty) * AVG(pch.StandardCost))) >= 28419.034708  -- Highly profitable
    AND SUM(sod.OrderQty) BETWEEN 449 AND 899  -- Moderate sales
ORDER BY 
    Profit DESC;  

--We have a total of 266 products (different product ids), so manually divide the products into three groups: 1-89; 90-178; 179-266.
-- Calculate total profit per product
SELECT 
    p.ProductID, 
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    SUM(sod.LineTotal) AS TotalRevenue,
    AVG(pch.StandardCost) AS AvgCost,
    (SUM(sod.LineTotal) - SUM(sod.OrderQty) * AVG(pch.StandardCost)) AS TotalProfit
FROM 
    Sales.SalesOrderDetail sod
INNER JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN 
    Production.ProductCostHistory pch ON p.ProductID = pch.ProductID
GROUP BY 
    p.ProductID, p.Name
ORDER BY 
    TotalProfit DESC;
--Highly profitable:>= 28419.034708

-- Calculate total sales for each product
SELECT 
    p.ProductID, 
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold
FROM 
    Sales.SalesOrderDetail sod
INNER JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.Name
ORDER BY 
    TotalQuantitySold DESC;
-- Moderate sales: BETWEEN 449 AND 899

--Ques 4
-- Product Performance by Region
SELECT 
    P.Name AS ProductName,
    ST.Name AS TerritoryName,
    SUM(sod.LineTotal) AS TotalRevenue
FROM 
    Sales.SalesOrderDetail sod
JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN 
    Production.Product P ON sod.ProductID = P.ProductID
JOIN 
    Sales.SalesTerritory ST ON soh.TerritoryID = ST.TerritoryID
GROUP BY 
    P.Name, ST.Name
ORDER BY 
    ST.Name, TotalRevenue DESC;

-- Ques 5
-- Product Performance by Time of Year
SELECT 
    P.Name AS ProductName,
    DATENAME(MONTH, soh.OrderDate) AS MonthName,
    SUM(sod.LineTotal) AS TotalRevenue
FROM 
    Sales.SalesOrderDetail sod
JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN 
    Production.Product P ON sod.ProductID = P.ProductID
GROUP BY 
    P.Name, DATENAME(MONTH, soh.OrderDate)
ORDER BY 
    MonthName, TotalRevenue DESC;

-- Ques 6
-- Commonly Purchased Together Products
SELECT 
    sod1.ProductID AS ProductID1,
    P1.Name AS ProductName1,
    sod2.ProductID AS ProductID2,
    P2.Name AS ProductName2,
    COUNT(*) AS TimesPurchasedTogether
FROM 
    Sales.SalesOrderDetail sod1
JOIN 
    Sales.SalesOrderDetail sod2 ON sod1.SalesOrderID = sod2.SalesOrderID 
    AND sod1.ProductID < sod2.ProductID -- Avoid self join on the same product
JOIN 
    Production.Product P1 ON sod1.ProductID = P1.ProductID
JOIN 
    Production.Product P2 ON sod2.ProductID = P2.ProductID
GROUP BY 
    sod1.ProductID, P1.Name, sod2.ProductID, P2.Name
ORDER BY 
    TimesPurchasedTogether DESC;