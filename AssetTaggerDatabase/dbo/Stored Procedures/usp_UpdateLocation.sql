CREATE PROCEDURE [dbo].[usp_UpdateLocation]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LocationID UNIQUEIDENTIFIER,
    @LocationAddress NVARCHAR(842) = NULL,
    @BuildingID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingLocationPermission BIT = (SELECT HasUpdatingLocationPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingLocationPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingLocationPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Location]
    SET
        LocationAddress = ISNULL(@LocationAddress, LocationAddress),
        BuildingID = ISNULL(@BuildingID, BuildingID)
    OUTPUT
        INSERTED.LocationID,
        INSERTED.LocationAddress,
        INSERTED.BuildingID,
        INSERTED.LocationInsertDate,
        DELETED.LocationAddress AS OldLocationAddress,
        DELETED.BuildingID AS OldBuildingID
    FROM
        [dbo].[Location]
    WHERE
        LocationID = @LocationID;
END;
