CREATE VIEW [dbo].[ReadableProduct]
AS
  SELECT p.ProductID, p.ProductName, p.ProductModelNumber, p.ProductManufacturer, c.CategoryID, c.CategoryName
  FROM [dbo].[Product] p
  INNER JOIN [dbo].[Category] c
    ON c.CategoryID = p.CategoryID
GO

