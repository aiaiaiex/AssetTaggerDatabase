CREATE PROCEDURE [dbo].[usp_CreateProductSet]
    @CallingEndUserId NVARCHAR(36),
    @ParentProductId UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER,
    @ProductQuantity INT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'ProductSet';

    -- Run actual query.
    INSERT INTO [dbo].[ProductSet] (
        ParentProductId,
        ProductId,
        ProductQuantity
    )
    OUTPUT
        INSERTED.ParentProductId,
        INSERTED.ProductId,
        INSERTED.ProductQuantity,
        INSERTED.CreatedAt
    VALUES (
        @ParentProductId,
        @ProductId,
        COALESCE(@ProductQuantity, 1)
    );
END;
