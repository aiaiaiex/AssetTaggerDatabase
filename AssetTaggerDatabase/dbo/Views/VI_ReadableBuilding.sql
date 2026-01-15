CREATE VIEW [dbo].[VI_ReadableBuilding]
AS
  SELECT b.BuildingID, b.BuildingName, b.BuildingAddress, b.CompanyID, c.CompanyName
  FROM [dbo].[Building] b
  INNER JOIN [dbo].[Company] c
    ON c.CompanyID = b.CompanyID