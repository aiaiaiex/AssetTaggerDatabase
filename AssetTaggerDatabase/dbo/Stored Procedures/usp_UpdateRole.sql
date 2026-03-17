CREATE PROCEDURE [dbo].[usp_UpdateRole]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @RoleID UNIQUEIDENTIFIER,
    @RoleName NVARCHAR(850) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateRole BIT;
    SELECT @UpdateRole = (SELECT UpdateRole FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateRole IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@UpdateRole = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Role!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    UPDATE [dbo].[Role]
    SET RoleName = ISNULL(@RoleName, RoleName)
    OUTPUT INSERTED.RoleID, INSERTED.RoleName, INSERTED.RoleInsertDate, DELETED.RoleName AS OldRoleName
    FROM [dbo].[Role]
    WHERE RoleID = @RoleID;
END
