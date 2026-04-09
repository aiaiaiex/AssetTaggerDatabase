CREATE PROCEDURE [dbo].[usp_CreateCategory]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Name NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingCategoryPermission BIT = (SELECT HasCreatingCategoryPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingCategoryPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingCategoryPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create a Category!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Category] (
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
