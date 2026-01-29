CREATE VIEW [dbo].[VI_ReadableProductSet]
AS
SELECT
    Ps.ParentProductID,
    Pr.ProductName AS ParentProductName,
    Ps.ProductID,
    Pro.ProductName
FROM [dbo].[ProductSet] AS Ps
INNER JOIN [dbo].[Product] AS Pr
    ON Ps.ParentProductID = Pr.ProductID
INNER JOIN [dbo].[Product] AS Pro
    ON Ps.ProductID = Pro.ProductID
