CREATE PROCEDURE [dbo].[usp_GetBuildingsOfSubsidiariesOfCompany]
    @ParentCompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.BuildingID
    FROM [dbo].[Building] b
    INNER JOIN [dbo].[tvf_GetSubsidiariesOfCompany](@ParentCompanyID) s
        ON s.SubsidiaryID = b.CompanyID
END
GO
