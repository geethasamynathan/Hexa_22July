
SELECT SO.OrderDate
, CASE
WHEN MONTH(OrderDate) BETWEEN 1 AND 3 THEN 'Quarter 1'
WHEN MONTH(OrderDate) BETWEEN 4 AND 6 THEN 'Quarter 2'
WHEN MONTH(OrderDate) BETWEEN 7 AND 9 THEN 'Quarter 3'
ELSE 'Quarter 4'
END 'Quarter'
, DATEPART(YEAR,SO.OrderDate) AS 'Order Year'
, SO.OrderID
, SOL.Quantity
, WSI.StockItemID
, WSI.StockItemName
, SCT.TransactionAmount
FROM SALES.Orders AS SO
INNER JOIN Sales.OrderLines AS SOL
ON SO.OrderID = SOL.OrderID
INNER JOIN Warehouse.StockItems AS WSI
ON SOL.StockItemID = WSI.StockItemID
INNER JOIN Sales.Invoices AS SI
ON SO.OrderID = SI.OrderID
INNER JOIN Sales.CustomerTransactions AS SCT
ON SCT.InvoiceID = SI.InvoiceID
GROUP BY SO.OrderID, SO.OrderDate, SOL.Quantity,SCT.TransactionAmount, WSI.StockItemID, WSI.StockItemName

