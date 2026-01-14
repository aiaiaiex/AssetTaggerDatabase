CREATE VIEW [dbo].[VI_ReadableCompany]
AS
  SELECT sc.ParentCompanyID, co.CompanyName as ParentCompanyName, sc.CompanyID, com.CompanyName
  FROM [dbo].[SubCompany] sc
  INNER JOIN [dbo].[Company] co
    ON co.CompanyID = sc.ParentCompanyID
  INNER JOIN [dbo].[Company] com
    ON com.CompanyID = sc.CompanyID
GO

