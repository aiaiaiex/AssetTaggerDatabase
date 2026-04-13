CREATE PROCEDURE [dbo].[usp_DeleteVendor]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
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
        DELETED.Id,
        DELETED.Name,
        DELETED.Address,
        DELETED.CreatedAt
    FROM
        [dbo].[Vendor]
    WHERE
        Id = @Id;
END;
