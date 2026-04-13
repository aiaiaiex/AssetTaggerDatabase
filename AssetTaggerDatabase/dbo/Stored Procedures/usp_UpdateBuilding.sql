CREATE PROCEDURE [dbo].[usp_UpdateBuilding]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @CompanyId UNIQUEIDENTIFIER = NULL
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
        Name = COALESCE(@Name, Name),
        Address = COALESCE(@Address, Address),
        CompanyId = COALESCE(@CompanyId, CompanyId)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CompanyId,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName,
        DELETED.Address AS OldAddress,
        DELETED.CompanyId AS OldCompanyId
    FROM
        [dbo].[Building]
    WHERE
        Id = @Id;
END;
