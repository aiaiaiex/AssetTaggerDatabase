CREATE PROCEDURE [dbo].[usp_CreateBuilding]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @BuildingName NVARCHAR(850),
    @BuildingAddress NVARCHAR(850),
    @CompanyID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateBuilding BIT = (SELECT CreateBuilding FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateBuilding IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateBuilding = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Building] (
        BuildingName,
        BuildingAddress,
        CompanyID
    )
    OUTPUT
        INSERTED.BuildingID,
        INSERTED.BuildingName,
        INSERTED.BuildingAddress,
        INSERTED.CompanyID,
        INSERTED.BuildingInsertDate
    VALUES (
        @BuildingName,
        @BuildingAddress,
        @CompanyID
    );
END;
