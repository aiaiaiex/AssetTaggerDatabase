CREATE VIEW [dbo].[VI_ReadableAsset]
AS
SELECT
    A.AssetID,
    A.AssetTagDate,
    A.AssetPurchaseDate,
    A.AssetPurchasePrice,
    A.AssetSerialNumber,
    A.AssetWarrantyUnitOfMeasure,
    A.AssetWarrantyDuration,
    A.AssetUsefulLife,
    A.AssetSalvageValue,
    A.ProductID,
    P.ProductName,
    A.VendorID,
    V.VendorName,
    A.LocationID,
    L.LocationAddress,
    A.EmployeeID,
    E.EmployeeFullName
FROM [dbo].[Asset] AS A
INNER JOIN [dbo].[Product] AS P
    ON A.ProductID = P.ProductID
INNER JOIN [dbo].[Vendor] AS V
    ON A.VendorID = V.VendorID
INNER JOIN [dbo].[Location] AS L
    ON A.LocationID = L.LocationID
LEFT JOIN [dbo].[Employee] AS E
    ON A.EmployeeID = E.EmployeeID
