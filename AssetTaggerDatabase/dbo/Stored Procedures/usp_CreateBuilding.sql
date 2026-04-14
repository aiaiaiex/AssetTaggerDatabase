CREATE PROCEDURE [dbo].[usp_CreateBuilding]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(850) = '',
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Building';

    -- Run actual query.
    INSERT INTO [dbo].[Building] (
        -- Non-nullable foreign keys.
        CompanyId,
        -- Non-nullable columns.
        Address,
        Name
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.CompanyId,
        -- Non-nullable columns.
        INSERTED.Address,
        INSERTED.Name
    VALUES (
        -- Non-nullable foreign keys.
        [dbo].[udf_GetDefaultUniqueidentifier](@CompanyId, NULL),
        -- Non-nullable columns.
        [dbo].[udf_GetDefaultNvarchar](@Address, NULL),
        [dbo].[udf_GetDefaultNvarchar](@Name, NULL)
    );
END;
