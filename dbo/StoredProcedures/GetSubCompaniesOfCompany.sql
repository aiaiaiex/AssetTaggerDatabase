CREATE PROCEDURE GetSubCompaniesOfCompany
    @ParentCompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CompanyID
    FROM [dbo].[SubCompany]
    WHERE ParentCompanyID = @ParentCompanyID;
END
GO

