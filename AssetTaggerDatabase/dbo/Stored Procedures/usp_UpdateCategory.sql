CREATE PROCEDURE [dbo].[usp_UpdateCategory]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36),
    -- Non-nullable columns.
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Category';

    -- Run actual query.
    UPDATE
        [dbo].[Category]
    SET
        -- Non-nullable columns.
        Name = [dbo].[udf_GetDefaultNvarchar](@Name, Name)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable columns.
        INSERTED.Name,
        -- Old values.
        -- Non-nullable columns.
        DELETED.Name AS OldName
    FROM
        [dbo].[Category]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
