CREATE PROCEDURE [dbo].[usp_DeleteRole]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @RoleID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteRole BIT = (SELECT DeleteRole FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteRole IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteRole = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Role!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Role]
    OUTPUT DELETED.RoleID, DELETED.RoleName, DELETED.RoleInsertDate
    FROM [dbo].[Role]
    WHERE RoleID = @RoleID;
END;
