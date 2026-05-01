CREATE PROCEDURE [dbo].[usp_CreateEndUser]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable foreign keys.
    @RoleId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Username NVARCHAR(850) = '',
    -- Secret parameters.
    @Password NVARCHAR(MAX) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable foreign keys.
        '@RoleId = ''', [dbo].[udf_ConvertNullToNvarchar](@RoleId), ''', ',
        -- Nullable foreign keys.
        '@EmployeeId = ''', [dbo].[udf_ConvertNullToNvarchar](@EmployeeId), ''', ',
        -- Non-nullable columns.
        '@Username = ''', [dbo].[udf_ConvertNullToNvarchar](@Username), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(836) = 'EndUser';
    DECLARE @EndUserIpAddress NVARCHAR(4000) = [dbo].[udf_GetDefaultNvarchar](@CallingEndUserIpAddress, NULL);

    DECLARE @EndUserId UNIQUEIDENTIFIER;
    DECLARE @EndedAt DATETIME2(3);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorNumber INT;

    BEGIN TRY
        -- Set final values.
        SET @EndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

        -- Check the permission of the calling EndUser.
        EXEC [dbo].[usp_HasPermission] @EndUserId, @Operation, @TableName;

        -- Create password salt.
        DECLARE @PasswordSalt UNIQUEIDENTIFIER = NEWID();

        -- Run actual query.
        INSERT INTO [dbo].[EndUser] (
            -- Non-nullable foreign keys.
            RoleId,
            -- Nullable foreign keys.
            EmployeeId,
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
            INSERTED.RoleId,
            -- Nullable foreign keys.
            INSERTED.EmployeeId,
            -- Non-nullable columns.
            INSERTED.Username
        VALUES (
            -- Non-nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@RoleId, NULL),
            -- Nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, NULL),
            -- Non-nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@Username, NULL),
            -- Secret columns.
            [dbo].[udf_HashPassword](CONCAT([dbo].[udf_GetDefaultNvarcharMax](@Password, NULL), CAST(@PasswordSalt AS NVARCHAR(36)))),
            @PasswordSalt
        );
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
