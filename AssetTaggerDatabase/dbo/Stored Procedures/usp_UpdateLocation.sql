CREATE PROCEDURE [dbo].[usp_UpdateLocation]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @Address NVARCHAR(842) = NULL,
    @BuildingId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Location';

    -- Run actual query.
    UPDATE
        [dbo].[Location]
    SET
        Address = COALESCE(@Address, Address),
        BuildingId = COALESCE(@BuildingId, BuildingId)
    OUTPUT
        INSERTED.Id,
        INSERTED.Address,
        INSERTED.BuildingId,
        INSERTED.CreatedAt,
        DELETED.Address AS OldAddress,
        DELETED.BuildingId AS OldBuildingId
    FROM
        [dbo].[Location]
    WHERE
        Id = @Id;
END;
