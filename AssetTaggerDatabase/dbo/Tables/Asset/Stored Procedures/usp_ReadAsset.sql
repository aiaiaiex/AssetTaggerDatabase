CREATE PROCEDURE [dbo].[usp_ReadAsset]
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
    @SerialNumber NVARCHAR(842) = '',
    @WarrantyUnitOfMeasure NVARCHAR(2) = '',
    -- BIGINT range parameters.
    @FromUsefulLife NVARCHAR(19) = '',
    @ToUsefulLife NVARCHAR(19) = '',
    @FromWarrantyDuration NVARCHAR(19) = '',
    @ToWarrantyDuration NVARCHAR(19) = '',
    -- DECIMAL(15, 4) range parameters.
    @FromAnnualDepreciationExpense NVARCHAR(17) = '',
    @ToAnnualDepreciationExpense NVARCHAR(17) = '',
    @FromCurrentBookValue NVARCHAR(17) = '',
    @ToCurrentBookValue NVARCHAR(17) = '',
    @FromPurchasePrice NVARCHAR(17) = '',
    @ToPurchasePrice NVARCHAR(17) = '',
    @FromSalvageValue NVARCHAR(17) = '',
    @ToSalvageValue NVARCHAR(17) = '',
    -- DATETIME2(3) range parameters.
    @FromCreatedAt NVARCHAR(24) = NULL,
    @ToCreatedAt NVARCHAR(24) = NULL,
    @FromPurchasedAt NVARCHAR(24) = '',
    @ToPurchasedAt NVARCHAR(24) = '',
    @FromWarrantyExpirationDate NVARCHAR(24) = '',
    @ToWarrantyExpirationDate NVARCHAR(24) = '',
    -- Sort parameters.
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = '',
    -- Pagination parameters.
    @RowsToSkip NVARCHAR(19) = '',
    @RowsToReturn NVARCHAR(19) = ''
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
        '@SerialNumber = ''', [dbo].[udf_ConvertNullToNvarchar](@SerialNumber), ''', ',
        '@WarrantyUnitOfMeasure = ''', [dbo].[udf_ConvertNullToNvarchar](@WarrantyUnitOfMeasure), ''', ',
        -- BIGINT range parameters.
        '@FromUsefulLife = ''', [dbo].[udf_ConvertNullToNvarchar](@FromUsefulLife), ''', ',
        '@ToUsefulLife = ''', [dbo].[udf_ConvertNullToNvarchar](@ToUsefulLife), ''', ',
        '@FromWarrantyDuration = ''', [dbo].[udf_ConvertNullToNvarchar](@FromWarrantyDuration), ''', ',
        '@ToWarrantyDuration = ''', [dbo].[udf_ConvertNullToNvarchar](@ToWarrantyDuration), ''', ',
        -- DECIMAL(15, 4) range parameters.
        '@FromAnnualDepreciationExpense = ''', [dbo].[udf_ConvertNullToNvarchar](@FromAnnualDepreciationExpense), ''', ',
        '@ToAnnualDepreciationExpense = ''', [dbo].[udf_ConvertNullToNvarchar](@ToAnnualDepreciationExpense), ''', ',
        '@FromCurrentBookValue = ''', [dbo].[udf_ConvertNullToNvarchar](@FromCurrentBookValue), ''', ',
        '@ToCurrentBookValue = ''', [dbo].[udf_ConvertNullToNvarchar](@ToCurrentBookValue), ''', ',
        '@FromPurchasePrice = ''', [dbo].[udf_ConvertNullToNvarchar](@FromPurchasePrice), ''', ',
        '@ToPurchasePrice = ''', [dbo].[udf_ConvertNullToNvarchar](@ToPurchasePrice), ''', ',
        '@FromSalvageValue = ''', [dbo].[udf_ConvertNullToNvarchar](@FromSalvageValue), ''', ',
        '@ToSalvageValue = ''', [dbo].[udf_ConvertNullToNvarchar](@ToSalvageValue), ''', ',
        -- DATETIME2(3) range parameters.
        '@FromCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@FromCreatedAt), ''', ',
        '@ToCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@ToCreatedAt), ''', ',
        '@FromPurchasedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@FromPurchasedAt), ''', ',
        '@ToPurchasedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@ToPurchasedAt), ''', ',
        '@FromWarrantyExpirationDate = ''', [dbo].[udf_ConvertNullToNvarchar](@FromWarrantyExpirationDate), ''', ',
        '@ToWarrantyExpirationDate = ''', [dbo].[udf_ConvertNullToNvarchar](@ToWarrantyExpirationDate), ''', ',
        -- Sort parameters.
        '@SortColumn = ''', [dbo].[udf_ConvertNullToNvarchar](@SortColumn), ''', ',
        '@RowOrder = ''', [dbo].[udf_ConvertNullToNvarchar](@RowOrder), ''', ',
        -- Pagination parameters.
        '@RowsToSkip = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToSkip), ''', ',
        '@RowsToReturn = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToReturn), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Read';
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

        -- Set final values.
        SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
        SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

        -- Run actual query.
        SELECT
            -- Non-nullable columns with default values.
            CreatedAt,
            Id,
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
            WarrantyUnitOfMeasure,
            -- Computed columns.
            AnnualDepreciationExpense,
            CurrentBookValue,
            WarrantyExpirationDate
        FROM
            [dbo].[Asset]
        WHERE
            -- Non-nullable columns with default values.
            [dbo].[udf_IsEqualToUniqueIdentifier](@Id, Id) = 1
            -- Non-nullable foreign keys.
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@ProductId, ProductId) = 1
            -- Nullable foreign keys.
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@EmployeeId, EmployeeId) = 1
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@LocationId, LocationId) = 1
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@VendorId, VendorId) = 1
            -- Nullable columns.
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@DocumentationUrl, DocumentationUrl) = 1
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@SerialNumber, SerialNumber) = 1
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@WarrantyUnitOfMeasure, WarrantyUnitOfMeasure) = 1
            -- BIGINT range parameters.
            AND [dbo].[udf_IsBetweenBigints](@FromUsefulLife, UsefulLife, @ToUsefulLife) = 1
            AND [dbo].[udf_IsBetweenBigints](@FromWarrantyDuration, WarrantyDuration, @ToWarrantyDuration) = 1
            -- DECIMAL(15, 4) range parameters.
            AND [dbo].[udf_IsBetweenDecimals](@FromAnnualDepreciationExpense, AnnualDepreciationExpense, @ToAnnualDepreciationExpense) = 1
            AND [dbo].[udf_IsBetweenDecimals](@FromCurrentBookValue, CurrentBookValue, @ToCurrentBookValue) = 1
            AND [dbo].[udf_IsBetweenDecimals](@FromPurchasePrice, PurchasePrice, @ToPurchasePrice) = 1
            AND [dbo].[udf_IsBetweenDecimals](@FromSalvageValue, SalvageValue, @ToSalvageValue) = 1
            -- DATETIME2(3) range parameters.
            AND [dbo].[udf_IsBetweenDatetime2s](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
            AND [dbo].[udf_IsBetweenDatetime2s](@FromPurchasedAt, PurchasedAt, @ToPurchasedAt) = 1
            AND [dbo].[udf_IsBetweenDatetime2s](@FromWarrantyExpirationDate, WarrantyExpirationDate, @ToWarrantyExpirationDate) = 1
        ORDER BY
        -- Descending sort.
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'PurchasedAt')) THEN PurchasedAt END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'PurchasePrice')) THEN PurchasePrice END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'SalvageValue')) THEN SalvageValue END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'SerialNumber')) THEN SerialNumber END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'UsefulLife')) THEN UsefulLife END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'WarrantyDuration')) THEN WarrantyDuration END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'WarrantyUnitOfMeasure')) THEN WarrantyUnitOfMeasure END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'AnnualDepreciationExpense')) THEN AnnualDepreciationExpense END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CurrentBookValue')) THEN CurrentBookValue END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'WarrantyExpirationDate')) THEN WarrantyExpirationDate END DESC,
            -- Ascending sort.
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'PurchasedAt')) THEN PurchasedAt END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'PurchasePrice')) THEN PurchasePrice END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'SalvageValue')) THEN SalvageValue END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'SerialNumber')) THEN SerialNumber END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'UsefulLife')) THEN UsefulLife END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'WarrantyDuration')) THEN WarrantyDuration END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'WarrantyUnitOfMeasure')) THEN WarrantyUnitOfMeasure END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'AnnualDepreciationExpense')) THEN AnnualDepreciationExpense END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CurrentBookValue')) THEN CurrentBookValue END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'WarrantyExpirationDate')) THEN WarrantyExpirationDate END ASC
            -- Pagination.
            OFFSET [dbo].[udf_GetRowsToSkip](@RowsToSkip) ROWS
            FETCH NEXT [dbo].[udf_GetRowsToReturn](@RowsToReturn) ROWS ONLY;
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
