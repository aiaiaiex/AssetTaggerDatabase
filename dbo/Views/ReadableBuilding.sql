CREATE VIEW [dbo].[ReadableBuilding]
AS
  SELECT b.BuilidingID, b.BuilidingName, b.BuildingAddress, b.CompanyID, c.CompanyName
  FROM [dbo].[Building] b
  INNER JOIN [dbo].[Company] c
    ON c.CompanyID = b.CompanyID
GO

