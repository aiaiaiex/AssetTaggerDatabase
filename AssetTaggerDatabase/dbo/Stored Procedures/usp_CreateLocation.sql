CREATE PROCEDURE [dbo].[usp_CreateLocation]
    @CallingEndUserId NVARCHAR(36),
    @Address NVARCHAR(842),
    @BuildingId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Location';

    -- Run actual query.
    INSERT INTO [dbo].[Location] (
        Address,
        BuildingId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Address,
        INSERTED.BuildingId,
        INSERTED.CreatedAt
    VALUES (
        @Address,
        @BuildingId
    );
END;
