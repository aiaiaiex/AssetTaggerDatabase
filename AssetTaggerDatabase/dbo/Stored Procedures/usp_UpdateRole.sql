CREATE PROCEDURE [dbo].[usp_UpdateRole]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Role';

    -- Run actual query.
    UPDATE
        [dbo].[Role]
    SET
        Name = COALESCE(@Name, Name)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName
    FROM
        [dbo].[Role]
    WHERE
        Id = @Id;
END;
