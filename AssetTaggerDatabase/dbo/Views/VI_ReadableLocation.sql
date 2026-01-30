CREATE VIEW [dbo].[VI_ReadableLocation]
AS
SELECT
    L.LocationID,
    L.LocationAddress,
    L.BuildingID,
    B.BuildingName
FROM [dbo].[Location] AS L
INNER JOIN [dbo].[Building] AS B
    ON L.BuildingID = B.BuildingID
