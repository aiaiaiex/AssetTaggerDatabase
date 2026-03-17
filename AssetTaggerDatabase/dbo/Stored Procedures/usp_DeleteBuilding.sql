CREATE PROCEDURE [dbo].[usp_DeleteBuilding]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @BuildingID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteBuilding BIT = (SELECT DeleteBuilding FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteBuilding IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteBuilding = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Building]
    OUTPUT
        DELETED.BuildingID,
        DELETED.BuildingName,
        DELETED.BuildingAddress,
        DELETED.CompanyID,
        DELETED.BuildingInsertDate
    FROM
        [dbo].[Building]
    WHERE
        BuildingID = @BuildingID;
END;
