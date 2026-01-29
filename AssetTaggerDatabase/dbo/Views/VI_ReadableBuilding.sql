CREATE VIEW [dbo].[VI_ReadableBuilding]
AS
SELECT
    B.BuildingID,
    B.BuildingName,
    B.BuildingAddress,
    B.CompanyID,
    C.CompanyName
FROM [dbo].[Building] AS B
INNER JOIN [dbo].[Company] AS C
    ON B.CompanyID = C.CompanyID
