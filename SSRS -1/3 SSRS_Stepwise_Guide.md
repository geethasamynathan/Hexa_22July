
# SSRS (SQL Server Reporting Services) – Beginner to Intermediate Stepwise Guide

## 1. Introduction – Reporting as Storytelling
- Reporting is not just about dumping data; it’s about telling a story.
- Example:  
  ❌ Boss asks: “How is our sales in Europe?” – Don’t return raw SQL table output.  
  ✅ Instead, tell: "Sales this year were good except in two countries due to seasonality. Our YTD sales trend is healthy when viewed monthly."
- Storytelling tools: SSRS, Tableau, QlikView, Power BI.
- This course focuses on SSRS.

## 2. What is SSRS?
- Microsoft Definition:  
  SQL Server Reporting Services is an on-premise solution for creating, publishing, managing, and delivering reports.
- Supports:
  - Viewing on Web, Mobile, or Email.
  - Multiple formats (Tabular, Matrix, Charts).
- Purpose:
  - Create and deliver pixel-perfect, interactive reports.

## 3. Getting Started – No Prerequisites
- Steps:
  1. Install SQL Server Database Engine.
  2. Install SQL Server Reporting Services (SSRS).
  3. Install Sample Databases (e.g., AdventureWorks).
- Use step-by-step PDF/Guide for installation.
- Post-installation, test databases and SSRS before report creation.

## 4. Creating First Report – Wizard Method
### Step 1 – Open Visual Studio
- Select New Project → Report Server Project Wizard.
- Name it (e.g., MyFirstReport).

### Step 2 – Configure Data Source
- Name: First Data Source.
- Connection String:  
  - Server: localhost\SQL2016 (or your instance name).  
  - Database: AdventureWorks.
- Test connection – ensure success.

### Step 3 – Create Dataset (Query)
- Use Query Builder.
- Add required tables (e.g., SalesTerritory).
- Select required columns.
- Run query to preview sample data.

### Step 4 – Choose Report Type
- Select Tabular or Matrix (Tabular for beginners).
- Arrange fields into Groups and Details.

### Step 5 – Table Layout & Preview
- Choose layout: Blocked or Stepped.
- Name report.
- Preview output – report is ready.

## 5. Creating First Report – Manual (Non-Wizard)
### Step 1 – New Project
- New Project → Report Server Project (no wizard).
- Add New Report in Reports folder.

### Step 2 – Create Data Source
- Name: MyDataSource.
- Server: localhost\SQL2016.
- Database: AdventureWorks2016.
- Test connection.

### Step 3 – Create Dataset
- Name: SalesTerritoryDataSet.
- Use Query Designer to select table & columns.
- Test query.

### Step 4 – Design Report Layout
- Add Text Box for title (“My First Report”).
- Add Table from toolbox.
- Drag dataset columns into table cells.
- Format (bold, underline, font changes).

### Step 5 – Preview
- Save credentials.
- Run report.

## 6. Adding Parameters
### Single Parameter
1. Edit dataset query:
   ```sql
   SELECT * FROM SalesTerritory
   WHERE CountryRegionCode = @CountryRegionCode
   ```
2. SSRS auto-creates parameter.
3. Run – enter value (e.g., US) to filter.

### Dropdown Parameter
1. Create dataset:
   ```sql
   SELECT DISTINCT CountryRegionCode FROM SalesTerritory
   ```
2. Link dataset to parameter’s Available Values.
3. User selects from dropdown.

## 7. Multiple & Cascading Parameters
### Example – Country & Territory
1. Main dataset filters on both:
   ```sql
   SELECT * FROM SalesTerritory
   WHERE CountryRegionCode = @CountryRegionCode
     AND TerritoryID = @TerritoryID
   ```
2. Create Country Parameter Dataset:
   ```sql
   SELECT DISTINCT CountryRegionCode FROM SalesTerritory
   ```
3. Create Territory Parameter Dataset (cascading):
   ```sql
   SELECT DISTINCT TerritoryID
   FROM SalesTerritory
   WHERE CountryRegionCode = @CountryRegionCode
   ```
4. Link:
   - CountryRegionCode parameter → Country dataset.
   - TerritoryID parameter → Territory dataset (filtered by selected country).

## 8. Expressions – Dynamic Formatting
- Expressions allow customization of:
  - Font color, background color, formatting.
  - Calculations & conditional logic.

### Example – Font Color by Threshold
- Select column → Properties → FontColor → Expression:
  ```vb
  =IIF(Fields!TerritoryID.Value <= 5, "Green", "Red")
  ```
- Preview:
  - ID ≤ 5 → Green text.
  - ID > 5 → Red text.

## 9. Key SSRS Concepts Learned
- Data Source: Connection to database.
- Dataset: Query or data retrieved from the source.
- Report Items: Tables, Charts, Text boxes, etc.
- Parameters: User-driven filters (single, multiple, cascading).
- Expressions: Custom logic for display & behavior.

## 10. Next Steps
- Add charts & KPIs for storytelling.
- Use grouping, sorting, and aggregations.
- Deploy reports to Report Server.
- Learn scheduling & subscriptions.
