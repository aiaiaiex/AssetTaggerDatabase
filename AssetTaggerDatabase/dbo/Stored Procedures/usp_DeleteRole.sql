CREATE PROCEDURE [dbo].[usp_DeleteRole]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingRolePermission BIT = (SELECT HasDeletingRolePermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingRolePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingRolePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a Role!', 11, 0);
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
