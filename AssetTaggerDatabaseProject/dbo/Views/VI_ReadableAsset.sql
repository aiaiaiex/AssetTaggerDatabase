CREATE VIEW [dbo].[VI_ReadableAsset]
AS
  SELECT a.AssetID, a.AssetTagDate, a.AssetPurchaseDate, a.AssetPurchasePrice, a.AssetSerialNumber, a.AssetWarrantyUnitOfMeasure, a.AssetWarrantyDuration, a.AssetUsefulLife, a.AssetSalvageValue, a.ProductID, p.ProductName, a.VendorID, v.VendorName, a.LocationID, l.LocationAddress, a.EmployeeID, e.EmployeeFullName
  FROM [dbo].[Asset] a
  INNER JOIN [dbo].[Product] p
    ON p.ProductID = a.ProductID
  INNER JOIN [dbo].[Vendor] v
    ON v.VendorID = a.VendorID
  INNER JOIN [dbo].[Location] l
    ON l.LocationID = a.LocationID
  INNER JOIN [dbo].[Employee] e
    ON e.EmployeeID = a.EmployeeID
GO

