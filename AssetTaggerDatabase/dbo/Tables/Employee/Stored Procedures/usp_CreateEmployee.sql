CREATE PROCEDURE [dbo].[usp_CreateEmployee]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    @DepartmentId NVARCHAR(36) = '',
    @JobId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @FullName NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Nullable foreign keys.
        '@CompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@CompanyId), ''', ',
        '@DepartmentId = ''', [dbo].[udf_ConvertNullToNvarchar](@DepartmentId), ''', ',
        '@JobId = ''', [dbo].[udf_ConvertNullToNvarchar](@JobId), ''', ',
        -- Non-nullable columns.
        '@FullName = ''', [dbo].[udf_ConvertNullToNvarchar](@FullName), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(836) = 'Employee';
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

        -- Run actual query.
        INSERT INTO [dbo].[Employee] (
            -- Nullable foreign keys.
            CompanyId,
            DepartmentId,
            JobId,
            -- Non-nullable columns.
            FullName
        )
        OUTPUT
            -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Nullable foreign keys.
            INSERTED.CompanyId,
            INSERTED.DepartmentId,
            INSERTED.JobId,
            -- Non-nullable columns.
            INSERTED.FullName
        VALUES (
            -- Nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@CompanyId, NULL),
            [dbo].[udf_GetDefaultUniqueidentifier](@DepartmentId, NULL),
            [dbo].[udf_GetDefaultUniqueidentifier](@JobId, NULL),
            -- Non-nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@FullName, NULL)
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

    -- Re-raise error.
    IF (@ErrorMessage IS NOT NULL)
        BEGIN
            RAISERROR (@ErrorMessage, 11, 0);
            RETURN -1;
        END;
END;
