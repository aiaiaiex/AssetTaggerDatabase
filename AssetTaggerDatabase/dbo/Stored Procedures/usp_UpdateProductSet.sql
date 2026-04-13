CREATE PROCEDURE [dbo].[usp_UpdateProductSet]
    @CallingEndUserId NVARCHAR(36),
    @ParentProductId UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER = NULL,
    @ProductQuantity INT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'ProductSet';

    -- Run actual query.
    UPDATE
        [dbo].[ProductSet]
    SET
        ProductQuantity = COALESCE(@ProductQuantity, ProductQuantity)
    OUTPUT
        INSERTED.ParentProductId,
        INSERTED.ProductId,
        INSERTED.ProductQuantity,
        INSERTED.CreatedAt,
        DELETED.ProductQuantity AS OldProductQuantity
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductId = @ParentProductId
        AND ProductId = COALESCE(@ProductId, ProductId);
END;
