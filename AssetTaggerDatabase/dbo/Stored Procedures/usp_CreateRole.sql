CREATE PROCEDURE [dbo].[usp_CreateRole]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @RoleName NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateRole BIT = (SELECT CreateRole FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateRole IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateRole = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Role!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Role] (
        RoleName
    )
    OUTPUT
        INSERTED.RoleID,
        INSERTED.RoleName,
        INSERTED.RoleInsertDate
    VALUES (
        @RoleName
    );
END;
