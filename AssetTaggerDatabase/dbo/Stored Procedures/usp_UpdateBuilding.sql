CREATE PROCEDURE [dbo].[usp_UpdateBuilding]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @BuildingID UNIQUEIDENTIFIER,
    @BuildingName NVARCHAR(850) = NULL,
    @BuildingAddress NVARCHAR(850) = NULL,
    @CompanyID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateBuilding BIT = (SELECT UpdateBuilding FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateBuilding IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@UpdateBuilding = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Building]
    SET
        BuildingName = ISNULL(@BuildingName, BuildingName),
        BuildingAddress = ISNULL(@BuildingAddress, BuildingAddress),
        CompanyID = ISNULL(@CompanyID, CompanyID)
    OUTPUT
        INSERTED.BuildingID,
        INSERTED.BuildingName,
        INSERTED.BuildingAddress,
        INSERTED.CompanyID,
        INSERTED.BuildingInsertDate,
        DELETED.BuildingName AS OldBuildingName,
        DELETED.BuildingAddress AS OldBuildingAddress,
        DELETED.CompanyID AS OldCompanyID
    FROM
        [dbo].[Building]
    WHERE
        BuildingID = @BuildingID;
END;
