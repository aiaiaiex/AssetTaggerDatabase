CREATE PROCEDURE [dbo].[usp_DeleteBuilding]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Building';

    -- Run actual query.
    DELETE [dbo].[Building]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.Address,
        DELETED.CompanyId,
        DELETED.CreatedAt
    FROM
        [dbo].[Building]
    WHERE
        Id = @Id;
END;
