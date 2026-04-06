CREATE PROCEDURE [dbo].[usp_DeleteRole]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingRolePermission BIT = (SELECT HasDeletingRolePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingRolePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingRolePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Role!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Role]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.CreatedAt
    FROM
        [dbo].[Role]
    WHERE
        Id = @Id;
END;
