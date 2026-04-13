CREATE PROCEDURE [dbo].[usp_DeleteManufacturer]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Manufacturer';

    -- Run actual query.
    DELETE [dbo].[Manufacturer]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.CreatedAt
    FROM
        [dbo].[Manufacturer]
    WHERE
        Id = @Id;
END;
