CREATE VIEW [dbo].[VI_ReadableCompany]

AS
  SELECT c.CompanyID, c.ParentCompanyID, co.CompanyName AS ParentCompanyName, c.CompanyName, c.CompanyAddress, c.CompanyCode
  FROM [dbo].[Company] c
  INNER JOIN [dbo].[Company] co
    ON c.ParentCompanyID = co.CompanyID
GO
