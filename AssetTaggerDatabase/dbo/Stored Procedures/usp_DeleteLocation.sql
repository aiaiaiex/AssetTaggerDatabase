CREATE PROCEDURE [dbo].[usp_DeleteLocation]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Location';

    -- Run actual query.
    DELETE [dbo].[Location]
    OUTPUT
        DELETED.Id,
        DELETED.Address,
        DELETED.BuildingId,
        DELETED.CreatedAt
    FROM
        [dbo].[Location]
    WHERE
        Id = @Id;
END;
