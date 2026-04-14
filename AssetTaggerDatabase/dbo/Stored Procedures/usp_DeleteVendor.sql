CREATE PROCEDURE [dbo].[usp_DeleteVendor]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Vendor';

    -- Run actual query.
    DELETE [dbo].[Vendor]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable columns.
        DELETED.Address,
        DELETED.Name
    FROM
        [dbo].[Vendor]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
