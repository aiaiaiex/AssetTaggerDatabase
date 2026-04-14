CREATE PROCEDURE [dbo].[usp_CreateProductSet]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @ProductQuantity NVARCHAR(10) = '',
    -- Non-nullable foreign keys.
    @ParentProductId NVARCHAR(36),
    @ProductId NVARCHAR(36)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'ProductSet';

    -- Run actual query.
    INSERT INTO [dbo].[ProductSet] (
        -- Non-nullable columns with default values.
        ProductQuantity,
        -- Non-nullable foreign keys.
        ParentProductId,
        ProductId
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.ProductQuantity,
        -- Non-nullable foreign keys.
        INSERTED.ParentProductId,
        INSERTED.ProductId
    VALUES (
        -- Non-nullable columns with default values.
        [dbo].[udf_GetIntColumnValue](@ProductQuantity, 1),
        -- Non-nullable foreign keys.
        [dbo].[udf_GetUniqueidentifier](@ParentProductId),
        [dbo].[udf_GetUniqueidentifier](@ProductId)
    );
END;
