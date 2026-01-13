CREATE VIEW [dbo].[VI_ReadableLocation]
AS
  SELECT l.LocationID, l.LocationAddress, l.BuildingID, b.BuilidingName
  FROM [dbo].[Location] l
  INNER JOIN [dbo].[Building] b
    ON b.BuilidingID = l.BuildingID
GO

