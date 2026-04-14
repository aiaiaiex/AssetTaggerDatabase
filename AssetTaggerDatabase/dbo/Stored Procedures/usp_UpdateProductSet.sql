CREATE PROCEDURE [dbo].[usp_UpdateProductSet]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @ProductQuantity NVARCHAR(10) = '',
    -- Non-nullable foreign keys.
    @ParentProductId NVARCHAR(36),
    @ProductId NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'ProductSet';

    -- Run actual query.
    UPDATE
        [dbo].[ProductSet]
    SET
        ProductQuantity = [dbo].[udf_GetDefaultInt](@ProductQuantity, ProductQuantity)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.ProductQuantity,
        -- Non-nullable foreign keys.
        INSERTED.ParentProductId,
        INSERTED.ProductId,
        -- Old values.
        -- Non-nullable columns with default values.
        DELETED.ProductQuantity AS OldProductQuantity
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductId = [dbo].[udf_GetDefaultUniqueidentifier](@ParentProductId, NULL)
        AND ProductId = [dbo].[udf_GetDefaultUniqueidentifier](@ProductId, ProductId);
END;
