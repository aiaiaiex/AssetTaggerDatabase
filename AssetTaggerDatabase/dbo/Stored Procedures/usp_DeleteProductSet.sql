CREATE PROCEDURE [dbo].[usp_DeleteProductSet]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable foreign keys.
    @ParentProductId NVARCHAR(36),
    @ProductId NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'ProductSet';

    -- Run actual query.
    DELETE [dbo].[ProductSet]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.ProductQuantity,
        -- Non-nullable foreign keys.
        DELETED.ParentProductId,
        DELETED.ProductId
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductId = [dbo].[udf_GetUniqueidentifier](@ParentProductId)
        AND ProductId = [dbo].[udf_GetUniqueidentifierColumnValue](@ProductId, ProductId);
END;
