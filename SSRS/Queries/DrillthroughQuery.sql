SELECT WSI.StockItemName
, WC.ColorName
, PS.SupplierName
, WSI.UnitPrice
FROM Warehouse.StockItems AS WSI
INNER JOIN Warehouse.Colors AS WC ON
WSI.ColorID = WC.ColorID
INNER JOIN Purchasing.Suppliers AS PS ON
WSI.SupplierID = PS.SupplierID
GROUP BY WSI.StockItemName, WC.ColorName, PS.SupplierName, WSI.UnitPrice

