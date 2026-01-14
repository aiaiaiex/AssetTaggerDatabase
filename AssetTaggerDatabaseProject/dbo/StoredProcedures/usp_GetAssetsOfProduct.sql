CREATE PROCEDURE [dbo].[usp_GetAssetsOfProduct]
    @ProductID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        AssetID
    FROM [dbo].[Asset] 
    WHERE ProductID = @ProductID;
END
GO

