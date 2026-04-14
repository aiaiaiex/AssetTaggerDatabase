CREATE PROCEDURE [dbo].[usp_UpdateBuilding]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36),
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(850) = '',
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Building';

    -- Run actual query.
    UPDATE
        [dbo].[Building]
    SET
        -- Non-nullable foreign keys.
        CompanyId = [dbo].[udf_GetUniqueidentifierColumnValue](@CompanyId, CompanyId),
        -- Non-nullable columns.
        Address = [dbo].[udf_GetNvarcharColumnValue](@Address, Address),
        Name = [dbo].[udf_GetNvarcharColumnValue](@Name, Name)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.CompanyId,
        -- Non-nullable columns.
        INSERTED.Address,
        INSERTED.Name,
        -- Old values.
        -- Non-nullable foreign keys.
        DELETED.CompanyId AS OldCompanyId,
        -- Non-nullable columns.
        DELETED.Address AS OldAddress,
        DELETED.Name AS OldName
    FROM
        [dbo].[Building]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
