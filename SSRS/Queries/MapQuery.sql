--MapQuery
SELECT SCT.CustomerID
, SC.DeliveryPostalCode
, SC.DeliveryLocation
, SCT.CustomerTransactionID
, SCT.TransactionAmount
FROM Sales.Customers AS SC
INNER JOIN Sales.CustomerTransactions AS SCT
ON SC.CustomerID = SCT.CustomerID
ORDER BY SCT.CustomerTransactionID
OFFSET 0 ROWS
FETCH FIRST 500 ROWS ONLY
