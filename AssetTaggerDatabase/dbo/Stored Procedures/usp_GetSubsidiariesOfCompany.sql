CREATE PROCEDURE [dbo].[usp_GetSubsidiariesOfCompany]
    @ParentCompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CompanyID
    FROM [dbo].[Company]
    WHERE ParentCompanyID = @ParentCompanyID;
END
