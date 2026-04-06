CREATE PROCEDURE [dbo].[usp_UpdateCategory]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CategoryID UNIQUEIDENTIFIER,
    @CategoryName NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingCategoryPermission BIT = (SELECT HasUpdatingCategoryPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingCategoryPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingCategoryPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Category!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Category]
    SET
        CategoryName = ISNULL(@CategoryName, CategoryName)
    OUTPUT
        INSERTED.CategoryID,
        INSERTED.CategoryName,
        INSERTED.CategoryInsertDate,
        DELETED.CategoryName AS OldCategoryName
    FROM
        [dbo].[Category]
    WHERE
        CategoryID = @CategoryID;
END;
