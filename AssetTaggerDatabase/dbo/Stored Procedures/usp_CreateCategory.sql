CREATE PROCEDURE [dbo].[usp_CreateCategory]
    @CallingEndUserId NVARCHAR(36),
    @Name NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Category';

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
