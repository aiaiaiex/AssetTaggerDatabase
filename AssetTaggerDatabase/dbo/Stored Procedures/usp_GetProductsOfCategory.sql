CREATE PROCEDURE [dbo].[usp_GetProductsOfCategory]
    @CategoryID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ProductID
    FROM [dbo].[Product]
    WHERE CategoryID = @CategoryID;
END
