CREATE PROCEDURE [dbo].[usp_CreateAsset]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable foreign keys.
    @ProductId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    @LocationId NVARCHAR(36) = '',
    @VendorId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @PurchasedAt NVARCHAR(24) = '',
    @PurchasePrice NVARCHAR(21) = '',
    @SalvageValue NVARCHAR(21) = '',
    @SerialNumber NVARCHAR(842) = '',
    @UsefulLife NVARCHAR(11) = '',
    @WarrantyDuration NVARCHAR(11) = '',
    @WarrantyUnitOfMeasure NVARCHAR(2) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable foreign keys.
        '@ProductId = ''', [dbo].[udf_ConvertNullToNvarchar](@ProductId), ''', ',
        -- Nullable foreign keys.
        '@EmployeeId = ''', [dbo].[udf_ConvertNullToNvarchar](@EmployeeId), ''', ',
        '@LocationId = ''', [dbo].[udf_ConvertNullToNvarchar](@LocationId), ''', ',
        '@VendorId = ''', [dbo].[udf_ConvertNullToNvarchar](@VendorId), ''', ',
        -- Nullable columns.
        '@DocumentationUrl = ''', [dbo].[udf_ConvertNullToNvarchar](@DocumentationUrl), ''', ',
        '@PurchasedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@PurchasedAt), ''', ',
        '@PurchasePrice = ''', [dbo].[udf_ConvertNullToNvarchar](@PurchasePrice), ''', ',
        '@SalvageValue = ''', [dbo].[udf_ConvertNullToNvarchar](@SalvageValue), ''', ',
        '@SerialNumber = ''', [dbo].[udf_ConvertNullToNvarchar](@SerialNumber), ''', ',
        '@UsefulLife = ''', [dbo].[udf_ConvertNullToNvarchar](@UsefulLife), ''', ',
        '@WarrantyDuration = ''', [dbo].[udf_ConvertNullToNvarchar](@WarrantyDuration), ''', ',
        '@WarrantyUnitOfMeasure = ''', [dbo].[udf_ConvertNullToNvarchar](@WarrantyUnitOfMeasure), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(4000) = 'Asset';
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
        INSERT INTO [dbo].[Asset] (
            -- Non-nullable foreign keys.
            ProductId,
            -- Nullable foreign keys.
            EmployeeId,
            LocationId,
            VendorId,
            -- Nullable columns.
            DocumentationUrl,
            PurchasedAt,
            PurchasePrice,
            SalvageValue,
            SerialNumber,
            UsefulLife,
            WarrantyDuration,
            WarrantyUnitOfMeasure
        )
        OUTPUT
            -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Non-nullable foreign keys.
            INSERTED.ProductId,
            -- Nullable foreign keys.
            INSERTED.EmployeeId,
            INSERTED.LocationId,
            INSERTED.VendorId,
            -- Nullable columns.
            INSERTED.DocumentationUrl,
            INSERTED.PurchasedAt,
            INSERTED.PurchasePrice,
            INSERTED.SalvageValue,
            INSERTED.SerialNumber,
            INSERTED.UsefulLife,
            INSERTED.WarrantyDuration,
            INSERTED.WarrantyUnitOfMeasure,
            -- Computed columns.
            INSERTED.AnnualDepreciationExpense,
            INSERTED.CurrentBookValue,
            INSERTED.WarrantyExpirationDate
        VALUES (
        -- Non-nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@ProductId, NULL),
            -- Nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, NULL),
            [dbo].[udf_GetDefaultUniqueidentifier](@LocationId, NULL),
            [dbo].[udf_GetDefaultUniqueidentifier](@VendorId, NULL),
            -- Nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@DocumentationUrl, NULL),
            [dbo].[udf_GetDefaultDatetime2](@PurchasedAt, NULL),
            [dbo].[udf_GetDefaultDecimal](@PurchasePrice, NULL),
            [dbo].[udf_GetDefaultDecimal](@SalvageValue, NULL),
            [dbo].[udf_GetDefaultNvarchar](@SerialNumber, NULL),
            [dbo].[udf_GetDefaultInt](@UsefulLife, NULL),
            [dbo].[udf_GetDefaultInt](@WarrantyDuration, NULL),
            [dbo].[udf_GetDefaultNvarchar](@WarrantyUnitOfMeasure, NULL)
        );
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateStoredProcedureLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
