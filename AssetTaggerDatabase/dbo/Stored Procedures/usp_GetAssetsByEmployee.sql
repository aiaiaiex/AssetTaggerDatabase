CREATE PROCEDURE [dbo].[usp_GetAssetsByEmployee]
    @EmployeeID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        AssetID
    FROM [dbo].[Asset] 
    WHERE EmployeeID = @EmployeeID;
END
