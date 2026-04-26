CREATE PROCEDURE [dbo].[usp_CreateProduct]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Nullable foreign keys.
    @CategoryId NVARCHAR(36) = '',
    @ManufacturerId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @ModelNumber NVARCHAR(421) = '',
    @Name NVARCHAR(421) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Nullable foreign keys.
        '@CategoryId = ''', [dbo].[udf_ConvertNullToNvarchar](@CategoryId), ''', ',
        '@ManufacturerId = ''', [dbo].[udf_ConvertNullToNvarchar](@ManufacturerId), ''', ',
        -- Nullable columns.
        '@DocumentationUrl = ''', [dbo].[udf_ConvertNullToNvarchar](@DocumentationUrl), ''', ',
        '@ModelNumber = ''', [dbo].[udf_ConvertNullToNvarchar](@ModelNumber), ''', ',
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(4000) = 'Product';
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
        INSERT INTO [dbo].[Product] (
            -- Nullable foreign keys.
            CategoryId,
            ManufacturerId,
            -- Nullable columns.
            DocumentationUrl,
            ModelNumber,
            Name
        )
        OUTPUT
        -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Nullable foreign keys.
            INSERTED.CategoryId,
            INSERTED.ManufacturerId,
            -- Nullable columns.
            INSERTED.DocumentationUrl,
            INSERTED.ModelNumber,
            INSERTED.Name
        VALUES (
            -- Nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@CategoryId, NULL),
            [dbo].[udf_GetDefaultUniqueidentifier](@ManufacturerId, NULL),
            -- Nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@DocumentationUrl, NULL),
            [dbo].[udf_GetDefaultNvarchar](@ModelNumber, NULL),
            [dbo].[udf_GetDefaultNvarchar](@Name, NULL)
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
