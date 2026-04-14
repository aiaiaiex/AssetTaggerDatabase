CREATE PROCEDURE [dbo].[usp_UpdateLocation]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @BuildingId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(842) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Location';

    -- Run actual query.
    UPDATE
        [dbo].[Location]
    SET
        -- Non-nullable foreign keys.
        BuildingId = [dbo].[udf_GetDefaultUniqueidentifier](@BuildingId, BuildingId),
        -- Non-nullable columns.
        Address = [dbo].[udf_GetDefaultNvarchar](@Address, Address)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.BuildingId,
        -- Non-nullable columns.
        INSERTED.Address,
        -- Old values.
        -- Non-nullable foreign keys.
        DELETED.BuildingId AS OldBuildingId,
        -- Non-nullable columns.
        DELETED.Address AS OldAddress
    FROM
        [dbo].[Location]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
