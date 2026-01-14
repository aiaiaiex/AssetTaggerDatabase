CREATE VIEW [dbo].[VI_ReadableLocation]
AS
  SELECT l.LocationID, l.LocationAddress, l.BuildingID, b.BuildingName
  FROM [dbo].[Location] l
  INNER JOIN [dbo].[Building] b
    ON b.BuildingID = l.BuildingID
GO

