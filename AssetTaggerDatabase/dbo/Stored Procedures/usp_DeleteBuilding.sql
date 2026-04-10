CREATE PROCEDURE [dbo].[usp_DeleteBuilding]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingBuildingPermission BIT = (SELECT HasDeletingBuildingPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingBuildingPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingBuildingPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a Building!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Building]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.Address,
        DELETED.CompanyId,
        DELETED.CreatedAt
    FROM
        [dbo].[Building]
    WHERE
        Id = @Id;
END;
