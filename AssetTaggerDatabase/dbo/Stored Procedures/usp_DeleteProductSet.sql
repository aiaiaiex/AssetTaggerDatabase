CREATE PROCEDURE [dbo].[usp_DeleteProductSet]
    @CallingEndUserId NVARCHAR(36),
    @ParentProductId UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'ProductSet';

    -- Run actual query.
    DELETE [dbo].[ProductSet]
    OUTPUT
        DELETED.ParentProductId,
        DELETED.ProductId,
        DELETED.ProductQuantity,
        DELETED.CreatedAt
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductId = @ParentProductId
        AND ProductId = COALESCE(@ProductId, ProductId);
END;
