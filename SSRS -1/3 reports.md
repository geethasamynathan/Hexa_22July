
![alt text](image.png)

![alt text](image-1.png)
![alt text](image-2.png)

![alt text](image-3.png)
![alt text](image-5.png)
![alt text](image-4.png)

![alt text](image-6.png)



## Non wizard Report

Report Server Project
![alt text](image-7.png)

![alt text](image-8.png)
```sql
SELECT TOP (1000) [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      FROM [AdventureWorks2014].[Sales].[SalesTerritory] 



SELECT TOP (1000) [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      FROM [AdventureWorks2014].[Sales].[SalesTerritory] where CountryRegionCode=@CountryRegionCode

```

      Right click ->Add Dataset
      ![alt text](image-9.png)

```sql
SELECT 
      Distinct CountryRegionCode    
      FROM [AdventureWorks2014].[Sales].[SalesTerritory]
```
![alt text](image-10.png)

![alt text](image-11.png)
Double click parameters in Report data Toolbox
![alt text](image-12.png)

![alt text](image-13.png)

## Next will add one more parameter
```sql
SELECT TOP (1000) [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      FROM [AdventureWorks2014].[Sales].[SalesTerritory] where CountryRegionCode=@CountryRegionCode
AND TerritoryID=@TerritoryID
```

![alt text](image-14.png)

# Let us Add cascading parameter based on we need to list related item in the next dropdown
For our example  above countrRegionCode once you selected conuntrycode as 'US' TerritoryID should list out automatically in the next dropdown


### Add New Dataset ->param_TerritoryID
``sql
SELECT 
DISTINCT TerritoryID 
 FROM [AdventureWorks2014].[Sales].[SalesTerritory] where CountryRegionCode=@CountryRegionCode

```
![alt text](image-15.png)

Attach dataset to parameter
![alt text](image-16.png)

![alt text](image-17.png)


# Expression

Expression is statement

Add TerritoryId column in the table
![alt text](image-18.png)

![alt text](image-19.png)

![alt text](image-20.png)

![alt text](image-21.png)



=Fields!SalesYTD.Value+10000
![alt text](image-23.png)
![alt text](image-22.png)


![alt text](image-24.png)

![alt text](image-25.png)
![alt text](image-26.png)

Add another textbox -> Expression
![alt text](image-27.png)

="Language = "+User!Language+"Page Number :"+Globals!PageNumber

as we are getting the error
# Let us Add PAge Header
![alt text](image-28.png)
![alt text](image-29.png)

Place textbox 
![alt text](image-30.png)