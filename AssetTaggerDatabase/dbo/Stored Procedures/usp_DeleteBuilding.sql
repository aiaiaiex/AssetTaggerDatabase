CREATE PROCEDURE [dbo].[usp_DeleteBuilding]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingBuildingPermission BIT = (SELECT HasDeletingBuildingPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingBuildingPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingBuildingPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Building]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.Address,
        DELETED.CompanyID,
        DELETED.CreatedAt
    FROM
        [dbo].[Building]
    WHERE
        Id = @Id;
END;
