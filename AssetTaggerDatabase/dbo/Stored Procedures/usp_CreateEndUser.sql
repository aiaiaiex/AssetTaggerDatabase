CREATE PROCEDURE [dbo].[usp_CreateEndUser]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    @EndUserRoleId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Username NVARCHAR(850) = '',
    -- Secret parameters.
    @Password NVARCHAR(MAX) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'EndUser';

    -- Create password salt.
    DECLARE @PasswordSalt UNIQUEIDENTIFIER = NEWID();

    -- Run actual query.
    INSERT INTO [dbo].[EndUser] (
        -- Non-nullable foreign keys.
        EmployeeId,
        EndUserRoleId,
        -- Non-nullable columns.
        Username,
        -- Secret columns.
        PasswordHash,
        PasswordSalt
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.EmployeeId,
        INSERTED.EndUserRoleId,
        -- Non-nullable columns.
        INSERTED.Username
    VALUES (
        -- Non-nullable foreign keys.
        [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, NULL),
        [dbo].[udf_GetDefaultUniqueidentifier](@EndUserRoleId, NULL),
        -- Non-nullable columns.
        [dbo].[udf_GetDefaultNvarchar](@Username, NULL),
        -- Secret columns.
        [dbo].[udf_HashPassword](CONCAT([dbo].[udf_GetDefaultNvarcharMax](@Password, NULL), CAST(@PasswordSalt AS NVARCHAR(36)))),
        @PasswordSalt
    );
END;
