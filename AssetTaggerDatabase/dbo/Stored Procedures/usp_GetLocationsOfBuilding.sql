CREATE PROCEDURE [dbo].[usp_GetLocationsOfBuilding]
    @BuildingID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        LocationID
    FROM [dbo].[Location]
    WHERE BuildingID = @BuildingID;
END
