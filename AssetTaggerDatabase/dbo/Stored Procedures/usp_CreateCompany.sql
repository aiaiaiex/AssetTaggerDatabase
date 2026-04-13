CREATE PROCEDURE [dbo].[usp_CreateCompany]
    @CallingEndUserId NVARCHAR(36),
    @Name NVARCHAR(850),
    @Address NVARCHAR(850),
    @Code NVARCHAR(5),
    @ParentCompanyId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Company';

    -- Run actual query.
    INSERT INTO [dbo].[Company] (
        Name,
        Address,
        Code,
        ParentCompanyId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.Code,
        INSERTED.ParentCompanyId,
        INSERTED.CreatedAt
    VALUES (
        @Name,
        @Address,
        @Code,
        @ParentCompanyId
    );
END;
