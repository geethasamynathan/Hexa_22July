--StockItemsQuery
SELECT WSG.StockGroupName
, WSI.StockItemName
, WSI.UnitPrice
FROM Warehouse.StockItems AS WSI
INNER JOIN Warehouse.StockItemStockGroups AS WSISG
ON WSI.StockItemID = WSISG.StockItemID
INNER JOIN Warehouse.StockGroups AS WSG
ON WSISG.StockGroupID = WSG.StockGroupID
GROUP BY WSG.StockGroupName, WSI.StockItemName, WSI.UnitPrice
