CREATE VIEW [dbo].[VI_ReadableAssetTransfer]
AS
SELECT
    Atr.AssetTransferID,
    Atr.AssetTransferDate,
    Atr.AssetTransferPrice,
    Atr.AssetID,
    P.ProductName,
    Atr.CompanyID,
    C.CompanyName,
    Atr.ReceivingCompanyID,
    Co.CompanyName AS ReceivingCompanyName
FROM [dbo].[AssetTransfer] AS Atr
INNER JOIN [dbo].[Asset] AS A
    ON Atr.AssetID = A.AssetID
INNER JOIN [dbo].[Product] AS P
    ON A.ProductID = P.ProductID
INNER JOIN [dbo].[Company] AS C
    ON Atr.CompanyID = C.CompanyID
INNER JOIN [dbo].[Company] AS Co
    ON Atr.ReceivingCompanyID = Co.CompanyID
