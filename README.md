# 🚴 AdventureWorks Product Performance & Marketing Intelligence

A Business Intelligence and Data Warehousing project built around the Microsoft AdventureWorks dataset to explore how data can support smarter sales and marketing decisions.

The project focuses on understanding which products perform best across online and in-store channels, how profitability changes across categories and regions, and what purchasing patterns can reveal about customer behaviour.

Using SQL Server, SSIS, SSAS, and Excel-based cube analysis, the project transforms raw transactional data into a structured analytical system that supports business decision-making.

---

## Project Structure

The project approaches AdventureWorks’ sales data from multiple analytical perspectives to understand product performance, profitability, and customer purchasing behaviour across online and in-store channels.

1. Product Popularity & Sales Analysis
  * Analysed product sales quantity across categories, regions, and sales channels
  * Identified the most and least popular products based on sales volume
  * Explored how product popularity impacts revenue and cost
2. Profitability Analysis
  * Evaluated product-level profitability using revenue, cost, and profit margin calculations
  * Compared online and in-store profitability trends
  * Identified high-margin and underperforming product categories
3. Regional & Seasonal Trend Analysis
  * Examined sales and profit performance across territories and countries
  * Analysed quarterly and yearly sales trends to identify seasonality patterns
4. Product Bundling & Purchasing Behaviour
  * Investigated products and categories frequently purchased together using SQL self-joins
  * Explored cross-selling and bundling opportunities to support marketing strategy
5. OLAP Cube Exploration
  * Built and explored an SSAS cube using Excel PivotTables
  * Enabled multidimensional analysis across products, territories, dates, discounts, and sales channels

---

## Business Questions Explored

1.	Which products are most/least popular, both in-store and online, and how does their popularity affect revenue and costs?
2.	Which products are most/least profitable, both in-store and online, and how does profitability impact the overall business?
3.	Based on product popularity and profitability, which products should AW target in their sales and marketing promotions to maximize growth?
4.	Which products perform best in specific markets (countries/regions)?
5.	Which products perform best during certain times of the year?

---

## Tech Stack

<p align="left">
  <img src="https://img.shields.io/badge/SSMS-Microsoft%20SQL%20Server-red?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" />
  <img src="https://img.shields.io/badge/SSIS-ETL-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/SSAS-OLAP-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Excel-Pivot%20Tables-green?style=for-the-badge&logo=microsoftexcel&logoColor=white" />
</p>

---

## Data Warehouse Design

The project follows a Star Schema architecture centered around the FactSales table.

### Fact Table
- FactSales

### Dimension Tables
- DimProduct
- DimDate
- DimSalesChannel
- DimSalesTerritory
- DimDiscount

This structure allows multidimensional analysis across products, geography, time, and sales channels while supporting efficient OLAP querying.

---

## ETL Pipeline (SSIS)

The ETL process extracted data from the AdventureWorks OLTP database and transformed it into a clean analytical warehouse.

Key ETL Features
- Data extraction from multiple source tables
- Merge joins across transactional datasets
- Derived calculations:
    * Sales Revenue
    * Profit Amount
    * Cost Amount
    * Discount Impact
- NULL handling and data cleansing
- Dimension enrichment
- Validation and row consistency checks

The pipeline processed over:

* 121,000+ sales transactions
* 500+ products
* Multiple geographic and channel dimensions
  
---
### SQL Methods Used
- Complex Joins (INNER JOIN, self joins for bundle analysis)
- Aggregations and Profitability Calculations (SUM, AVG, GROUP BY)
- Conditional Logic using CASE WHEN for Online vs In-Store analysis
- Revenue, Cost, and Profit Margin calculations
- Product Bundling Analysis using self joins and transaction pairing
- Regional and Seasonal Trend Analysis
- Ranking and sorting high- and low-performing products
- Multidimensional sales analysis across products, territories, and sales channels

---

## OLAP Cube & Analysis (SSAS)

An SSAS cube was created to support dynamic business analysis using:

- Product hierarchies
- Time hierarchies
- Geographic drill-downs
- Sales channel comparisons

The OLAP cube included measures such as Sales Revenue, Profit Amount, Profit Margin, Discount Impact, Sales Quantity, and Cost Amount, enabling multidimensional analysis through Excel PivotTables and interactive cube browsing.

---

## Key Insights

### Product Performance

* Bikes were the strongest-performing category overall, especially online.
* Accessories and clothing showed strong online demand.
* Premium bike models generated significantly higher revenue despite lower sales volumes.

### Profitability

* The Mountain-200 series emerged as one of the most profitable product lines.
* Tires and Tubes showed some of the highest profit margins across categories.
* Online channels consistently outperformed in-store sales in profitability.

### Customer Purchasing Behaviour

SQL-based bundle analysis revealed strong relationships between:

* Helmets and jerseys
* Bikes and components
* Accessories frequently purchased alongside bikes

These patterns helped inform recommendations around bundling and promotional strategy.


---

## Why I Built This

What interested me most about this project was not just building the warehouse itself, but understanding how business decisions emerge from data.

The project combines technical implementation with analytical storytelling, transforming raw transactional data into insights that can support pricing, promotions, inventory planning, and customer strategy.

It was also a practical introduction to how Business Intelligence systems are designed in real organisational settings.

---

## Files Included

* SQL queries used for analytical exploration
* Final project report
* Excel PivotTable analysis and visualizations

---
