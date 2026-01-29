CREATE PROCEDURE [dbo].[usp_GetBuildingsOfSubsidiariesOfCompany]
    @ParentCompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT B.BuildingID
    FROM [dbo].[Building] AS B
    INNER JOIN [dbo].[tvf_GetSubsidiariesOfCompany](@ParentCompanyID) AS S
        ON B.CompanyID = S.SubsidiaryID
END
