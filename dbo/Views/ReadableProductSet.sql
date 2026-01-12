CREATE VIEW [dbo].[ReadableProductSet]
AS
  SELECT ps.ParentProductID, pr.ProductName as ParentProductName, ps.ProductID, pro.ProductName
  FROM [dbo].[ProductSet] ps
  INNER JOIN [dbo].[Product] pr
    ON pr.ProductID = ps.ParentProductID
  INNER JOIN [dbo].[Product] pro
    ON pro.ProductID = ps.ProductID
GO

