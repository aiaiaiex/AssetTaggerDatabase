CREATE PROCEDURE [dbo].[usp_UpdateCategory]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingCategoryPermission BIT = (SELECT HasUpdatingCategoryPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingCategoryPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingCategoryPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Category!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Category]
    SET
        Name = COALESCE(@Name, Name)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName
    FROM
        [dbo].[Category]
    WHERE
        Id = @Id;
END;
