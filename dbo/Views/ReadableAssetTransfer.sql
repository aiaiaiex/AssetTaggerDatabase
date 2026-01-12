CREATE VIEW [dbo].[ReadableAssetTransfer]
AS
  SELECT atr.AssetTransferID, atr.AssetTransferDate, atr.AssetTransferPrice, atr.AssetID, p.ProductName, atr.CompanyID, c.CompanyName, atr.ReceivingCompanyID, co.CompanyName as ReceivingCompanyName
  FROM [dbo].[AssetTransfer] atr
  INNER JOIN [dbo].[Asset] a
    ON a.AssetID = atr.AssetID
  INNER JOIN [dbo].[Product] p
    ON p.ProductID = a.ProductID
  INNER JOIN [dbo].[Company] c
    ON c.CompanyID = atr.CompanyID
  INNER JOIN [dbo].[Company] co
    ON co.CompanyID = atr.ReceivingCompanyID
GO

