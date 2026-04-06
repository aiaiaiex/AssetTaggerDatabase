CREATE PROCEDURE [dbo].[usp_DeleteCategory]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CategoryID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingCategoryPermission BIT = (SELECT HasDeletingCategoryPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingCategoryPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingCategoryPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Category!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Category]
    OUTPUT
        DELETED.CategoryID,
        DELETED.CategoryName,
        DELETED.CategoryInsertDate
    FROM
        [dbo].[Category]
    WHERE
        CategoryID = @CategoryID;
END;
