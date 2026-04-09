CREATE PROCEDURE [dbo].[usp_UpdateLocation]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Address NVARCHAR(842) = NULL,
    @BuildingID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingLocationPermission BIT = (SELECT HasUpdatingLocationPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingLocationPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingLocationPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Location]
    SET
        Address = ISNULL(@Address, Address),
        BuildingID = ISNULL(@BuildingID, BuildingID)
    OUTPUT
        INSERTED.Id,
        INSERTED.Address,
        INSERTED.BuildingID,
        INSERTED.CreatedAt,
        DELETED.Address AS OldAddress,
        DELETED.BuildingID AS OldBuildingID
    FROM
        [dbo].[Location]
    WHERE
        Id = @Id;
END;
