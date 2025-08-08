--MobileQueryByYear
SELECT SUM(SCT.TransactionAmount) AS 'Total Transaction Amount'
, DATEPART(YEAR,SO.OrderDate) AS Year
FROM Sales.Orders AS SO
INNER JOIN Sales.CustomerTransactions AS SCT
ON SO.CustomerID = SCT.CustomerID
GROUP BY DATEPART(YEAR,SO.OrderDate)
