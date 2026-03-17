CREATE PROCEDURE [dbo].[usp_CreateLocation]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LocationAddress NVARCHAR(842),
    @BuildingID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateLocation BIT = (SELECT CreateLocation FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateLocation IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateLocation = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Location] (
        LocationAddress,
        BuildingID
    )
    OUTPUT
        INSERTED.LocationID,
        INSERTED.LocationAddress,
        INSERTED.BuildingID,
        INSERTED.LocationInsertDate
    VALUES (
        @LocationAddress,
        @BuildingID
    );
END;
