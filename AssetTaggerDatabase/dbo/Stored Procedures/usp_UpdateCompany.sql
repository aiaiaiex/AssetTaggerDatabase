CREATE PROCEDURE [dbo].[usp_UpdateCompany]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @ParentCompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(850) = '',
    @Code NVARCHAR(5) = '',
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Company';

    -- Run actual query.
    UPDATE
        [dbo].[Company]
    SET
        -- Nullable foreign keys.
        ParentCompanyId = [dbo].[udf_GetDefaultUniqueidentifier](@ParentCompanyId, ParentCompanyId),
        -- Non-nullable columns.
        Address = [dbo].[udf_GetDefaultNvarchar](@Address, Address),
        Code = [dbo].[udf_GetDefaultNvarchar](@Code, Code),
        Name = [dbo].[udf_GetDefaultNvarchar](@Name, Name)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Nullable foreign keys.
        INSERTED.ParentCompanyId,
        -- Non-nullable columns.
        INSERTED.Address,
        INSERTED.Code,
        INSERTED.Name,
        -- Old values.
        -- Nullable foreign keys.
        DELETED.ParentCompanyId AS OldParentCompanyId,
        -- Non-nullable columns.
        DELETED.Address AS OldAddress,
        DELETED.Code AS OldCode,
        DELETED.Name AS OldName
    FROM
        [dbo].[Company]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
