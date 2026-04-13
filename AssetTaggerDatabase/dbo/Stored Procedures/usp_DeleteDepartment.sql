CREATE PROCEDURE [dbo].[usp_DeleteDepartment]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Department';

    -- Run actual query.
    DELETE [dbo].[Department]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.CreatedAt
    FROM
        [dbo].[Department]
    WHERE
        Id = @Id;
END;
