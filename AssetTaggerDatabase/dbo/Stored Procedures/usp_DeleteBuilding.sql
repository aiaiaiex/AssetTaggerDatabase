CREATE PROCEDURE [dbo].[usp_DeleteBuilding]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Building';

    -- Run actual query.
    DELETE [dbo].[Building]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable foreign keys.
        DELETED.CompanyId,
        -- Non-nullable columns.
        DELETED.Address,
        DELETED.Name
    FROM
        [dbo].[Building]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
