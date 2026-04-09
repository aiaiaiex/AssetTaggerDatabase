CREATE PROCEDURE [dbo].[usp_CreateLocation]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Address NVARCHAR(842),
    @BuildingId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingLocationPermission BIT = (SELECT HasCreatingLocationPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingLocationPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingLocationPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create a Location!', 11, 0);
            RETURN -1;
        END;

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
