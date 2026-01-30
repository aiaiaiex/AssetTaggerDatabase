CREATE VIEW [dbo].[VI_ReadableCompany]

AS
SELECT
    C.CompanyID,
    C.ParentCompanyID,
    Co.CompanyName AS ParentCompanyName,
    C.CompanyName,
    C.CompanyAddress,
    C.CompanyCode
FROM [dbo].[Company] AS C
LEFT JOIN [dbo].[Company] AS Co
    ON C.ParentCompanyID = Co.CompanyID
