CREATE PROCEDURE [dbo].[usp_GetBuildingsOfSubcompaniesOfCompany]
    @ParentCompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.BuildingID
    FROM [dbo].[Building] b
    INNER JOIN [dbo].[udf_GetSubCompaniesOfCompany](@ParentCompanyID) sc
        ON sc.SubCompanyID = b.CompanyID
END
GO

