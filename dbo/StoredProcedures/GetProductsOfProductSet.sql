CREATE PROCEDURE [dbo].[GetProductsOfProductSet]
    @ParentProductID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ProductID
    FROM [dbo].[ProductSet]
    WHERE ParentProductID = @ParentProductID;
END
GO

