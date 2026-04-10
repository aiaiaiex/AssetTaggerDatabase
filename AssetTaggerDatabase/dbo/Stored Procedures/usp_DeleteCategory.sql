CREATE PROCEDURE [dbo].[usp_DeleteCategory]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingCategoryPermission BIT = (SELECT HasDeletingCategoryPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingCategoryPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingCategoryPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a Category!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Category]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.CreatedAt
    FROM
        [dbo].[Category]
    WHERE
        Id = @Id;
END;
