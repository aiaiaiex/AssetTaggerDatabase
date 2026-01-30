CREATE VIEW [dbo].[VI_ReadableProduct]
AS
SELECT
    P.ProductID,
    P.ProductName,
    P.ProductModelNumber,
    P.ManufacturerID,
    M.ManufacturerName,
    P.CategoryID,
    C.CategoryName
FROM [dbo].[Product] AS P
INNER JOIN [dbo].[Category] AS C
    ON P.CategoryID = C.CategoryID
LEFT JOIN [dbo].[Manufacturer] AS M
    ON P.ManufacturerID = M.ManufacturerID
