CREATE PROCEDURE GetParentCompanyOfCompany   
    @CompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ParentCompanyID
    FROM [dbo].[SubCompany]
    WHERE CompanyID = @CompanyID

END
GO

