--MobileQuery
SELECT OrderDate
, SUM(SCT.TransactionAmount) AS 'Total Transaction Amount'
, DATEPART(YEAR,SO.OrderDate) AS 'Order Year'
FROM Sales.Orders AS SO
INNER JOIN Sales.CustomerTransactions AS SCT
ON SO.CustomerID = SCT.CustomerID
GROUP BY SO.OrderDate
ORDER BY SO.OrderDate
