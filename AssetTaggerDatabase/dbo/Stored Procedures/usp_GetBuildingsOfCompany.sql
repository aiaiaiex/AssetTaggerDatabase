CREATE PROCEDURE [dbo].[usp_GetBuildingsOfCompany]
    @CompanyID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT BuildingID
    FROM [dbo].[Building]
    WHERE CompanyID = @CompanyID;
END
