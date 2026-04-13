CREATE PROCEDURE [dbo].[usp_CreateBuilding]
    @CallingEndUserId NVARCHAR(36),
    @Name NVARCHAR(850),
    @Address NVARCHAR(850),
    @CompanyId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Building';

    -- Run actual query.
    INSERT INTO [dbo].[Building] (
        Name,
        Address,
        CompanyId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CompanyId,
        INSERTED.CreatedAt
    VALUES (
        @Name,
        @Address,
        @CompanyId
    );
END;
