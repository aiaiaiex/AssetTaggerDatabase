CREATE VIEW [dbo].[VI_ReadableProduct]
AS
  SELECT p.ProductID, p.ProductName, p.ProductModelNumber, p.ManufacturerID, m.ManufacturerName, p.CategoryID, c.CategoryName
  FROM [dbo].[Product] p
  INNER JOIN [dbo].[Category] c
    ON c.CategoryID = p.CategoryID
  LEFT JOIN [dbo].[Manufacturer] m
    ON m.ManufacturerID = p.ManufacturerID
