CREATE PROCEDURE [dbo].[usp_DeleteLocation]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingLocationPermission BIT = (SELECT HasDeletingLocationPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingLocationPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingLocationPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Location]
    OUTPUT
        DELETED.Id,
        DELETED.Address,
        DELETED.BuildingID,
        DELETED.CreatedAt
    FROM
        [dbo].[Location]
    WHERE
        Id = @Id;
END;
