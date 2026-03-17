CREATE PROCEDURE [dbo].[usp_CreateCategory]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CategoryName NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateCategory BIT = (SELECT CreateCategory FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateCategory IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateCategory = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Category!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Category] (
        CategoryName
    )
    OUTPUT
        INSERTED.CategoryID,
        INSERTED.CategoryName,
        INSERTED.CategoryInsertDate
    VALUES (
        @CategoryName
    );
END;
