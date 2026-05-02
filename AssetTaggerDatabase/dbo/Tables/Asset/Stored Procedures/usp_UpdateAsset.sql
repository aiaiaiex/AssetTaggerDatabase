CREATE PROCEDURE [dbo].[usp_UpdateAsset]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @ProductId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    @LocationId NVARCHAR(36) = '',
    @VendorId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @PurchasedAt NVARCHAR(24) = '',
    @PurchasePrice NVARCHAR(17) = '',
    @SalvageValue NVARCHAR(17) = '',
    @SerialNumber NVARCHAR(842) = '',
    @UsefulLife NVARCHAR(19) = '',
    @WarrantyDuration NVARCHAR(19) = '',
    @WarrantyUnitOfMeasure NVARCHAR(2) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
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
    DECLARE @Operation NVARCHAR(6) = 'Update';
    DECLARE @TableName NVARCHAR(836) = 'Asset';
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
        UPDATE
            [dbo].[Asset]
        SET
            -- Non-nullable foreign keys.
            ProductId = [dbo].[udf_GetDefaultUniqueidentifier](@ProductId, ProductId),
            -- Nullable foreign keys.
            EmployeeId = [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, EmployeeId),
            LocationId = [dbo].[udf_GetDefaultUniqueidentifier](@LocationId, LocationId),
            VendorId = [dbo].[udf_GetDefaultUniqueidentifier](@VendorId, VendorId),
            -- Nullable columns.
            DocumentationUrl = [dbo].[udf_GetDefaultNvarchar](@DocumentationUrl, DocumentationUrl),
            PurchasedAt = [dbo].[udf_GetDefaultDatetime2](@PurchasedAt, PurchasedAt),
            PurchasePrice = [dbo].[udf_GetDefaultDecimal](@PurchasePrice, PurchasePrice),
            SalvageValue = [dbo].[udf_GetDefaultDecimal](@SalvageValue, SalvageValue),
            SerialNumber = [dbo].[udf_GetDefaultNvarchar](@SerialNumber, SerialNumber),
            UsefulLife = [dbo].[udf_GetDefaultBigint](@UsefulLife, UsefulLife),
            WarrantyDuration = [dbo].[udf_GetDefaultBigint](@WarrantyDuration, WarrantyDuration),
            WarrantyUnitOfMeasure = [dbo].[udf_GetDefaultNvarchar](@WarrantyUnitOfMeasure, WarrantyUnitOfMeasure)
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
            INSERTED.WarrantyExpirationDate,
            -- Old values.
            -- Non-nullable foreign keys.
            DELETED.ProductId AS OldProductId,
            -- Nullable foreign keys.
            DELETED.EmployeeId AS OldEmployeeId,
            DELETED.LocationId AS OldLocationId,
            DELETED.VendorId AS OldVendorId,
            -- Nullable columns.
            DELETED.DocumentationUrl AS OldDocumentationUrl,
            DELETED.PurchasedAt AS OldPurchasedAt,
            DELETED.PurchasePrice AS OldPurchasePrice,
            DELETED.SalvageValue AS OldSalvageValue,
            DELETED.SerialNumber AS OldSerialNumber,
            DELETED.UsefulLife AS OldUsefulLife,
            DELETED.WarrantyDuration AS OldWarrantyDuration,
            DELETED.WarrantyUnitOfMeasure AS OldWarrantyUnitOfMeasure,
            -- Computed columns.
            DELETED.AnnualDepreciationExpense AS OldAnnualDepreciationExpense,
            DELETED.CurrentBookValue AS OldCurrentBookValue,
            DELETED.WarrantyExpirationDate AS OldWarrantyExpirationDate
        FROM
            [dbo].[Asset]
        WHERE
            Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
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
