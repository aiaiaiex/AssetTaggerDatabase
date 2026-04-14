CREATE PROCEDURE [dbo].[usp_CreateLocation]
    @CallingEndUserId NVARCHAR(36) = '',
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
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Location';

    -- Run actual query.
    INSERT INTO [dbo].[Location] (
        -- Non-nullable foreign keys.
        BuildingId,
        -- Non-nullable columns.
        Address
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.BuildingId,
        -- Non-nullable columns.
        INSERTED.Address
    VALUES (
        -- Non-nullable foreign keys.
        [dbo].[udf_GetDefaultUniqueidentifier](@BuildingId, NULL),
        -- Non-nullable columns.
        [dbo].[udf_GetDefaultNvarchar](@Address, NULL)
    );
END;
