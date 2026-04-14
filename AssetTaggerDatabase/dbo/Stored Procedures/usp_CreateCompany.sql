CREATE PROCEDURE [dbo].[usp_CreateCompany]
    @CallingEndUserId NVARCHAR(36),
    -- Nullable foreign keys.
    @ParentCompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(850),
    @Code NVARCHAR(5),
    @Name NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Company';

    -- Run actual query.
    INSERT INTO [dbo].[Company] (
        -- Nullable foreign keys.
        ParentCompanyId,
        -- Non-nullable columns.
        Address,
        Code,
        Name
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Nullable foreign keys.
        INSERTED.ParentCompanyId,
        -- Non-nullable columns.
        INSERTED.Address,
        INSERTED.Code,
        INSERTED.Name
    VALUES (
        -- Nullable foreign keys.
        [dbo].[udf_GetUniqueidentifier](@ParentCompanyId),
        -- Non-nullable columns.
        [dbo].[udf_GetNvarchar](@Address),
        [dbo].[udf_GetNvarchar](@Code),
        [dbo].[udf_GetNvarchar](@Name)
    );
END;
