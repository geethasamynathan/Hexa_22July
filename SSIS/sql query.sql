/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CustomerID]
      ,[PersonID]
      ,[StoreID]
      ,[TerritoryID]
      ,[AccountNumber]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2014].[Sales].[Customer]

select max(territoryID) from sales.customer

select * from sales.customer where TerritoryID=1

select * from sales.customer where TerritoryID=2