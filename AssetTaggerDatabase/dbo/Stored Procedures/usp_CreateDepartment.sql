CREATE PROCEDURE [dbo].[usp_CreateDepartment]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Name NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingDepartmentPermission BIT = (SELECT HasCreatingDepartmentPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingDepartmentPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingDepartmentPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create a Department!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Department] (
        Name
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt
    VALUES (
        @Name
    );
END;
