CREATE PROCEDURE [dbo].[usp_UpdateCompany]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @Code NVARCHAR(5) = NULL,
    @ParentCompanyId NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Company';

    -- Run actual query.
    UPDATE
        [dbo].[Company]
    SET
        Name = COALESCE(@Name, Name),
        Address = COALESCE(@Address, Address),
        Code = COALESCE(@Code, Code),
        ParentCompanyId = CAST([dbo].[udf_GetColumnValue](@ParentCompanyId, ParentCompanyId) AS UNIQUEIDENTIFIER)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.Code,
        INSERTED.ParentCompanyId,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName,
        DELETED.Address AS OldAddress,
        DELETED.Code AS OldCode,
        DELETED.ParentCompanyId AS OldParentCompanyId
    FROM
        [dbo].[Company]
    WHERE
        Id = @Id;
END;
