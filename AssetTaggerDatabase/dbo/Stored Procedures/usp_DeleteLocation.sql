CREATE PROCEDURE [dbo].[usp_DeleteLocation]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LocationID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteLocation BIT = (SELECT DeleteLocation FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteLocation IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteLocation = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Location]
    OUTPUT
        DELETED.LocationID,
        DELETED.LocationAddress,
        DELETED.BuildingID,
        DELETED.LocationInsertDate
    FROM
        [dbo].[Location]
    WHERE
        LocationID = @LocationID;
END;
