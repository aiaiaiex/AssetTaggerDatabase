CREATE PROCEDURE [dbo].[usp_UpdateDepartment]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Department';

    -- Run actual query.
    UPDATE
        [dbo].[Department]
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
        [dbo].[Department]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
