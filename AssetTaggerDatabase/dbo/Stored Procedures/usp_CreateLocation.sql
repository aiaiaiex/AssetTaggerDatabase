CREATE PROCEDURE [dbo].[usp_CreateLocation]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Address NVARCHAR(842),
    @BuildingID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingLocationPermission BIT = (SELECT HasCreatingLocationPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasCreatingLocationPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingLocationPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Location] (
        Address,
        BuildingID
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Address,
        INSERTED.BuildingID,
        INSERTED.CreatedAt
    VALUES (
        @Address,
        @BuildingID
    );
END;
