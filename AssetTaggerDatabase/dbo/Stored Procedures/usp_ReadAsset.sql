CREATE PROCEDURE [dbo].[usp_ReadAsset]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    @LocationId NVARCHAR(36) = '',
    @ProductId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @VendorId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @SerialNumber NVARCHAR(842) = '',
    @WarrantyUnitOfMeasure NVARCHAR(2) = '',
    -- INT range parameters.
    @FromUsefulLife NVARCHAR(11) = '',
    @ToUsefulLife NVARCHAR(11) = '',
    @FromWarrantyDuration NVARCHAR(11) = '',
    @ToWarrantyDuration NVARCHAR(11) = '',
    -- DECIMAL(19, 4) range parameters.
    @FromAnnualDepreciationExpense NVARCHAR(21) = '',
    @ToAnnualDepreciationExpense NVARCHAR(21) = '',
    @FromCurrentBookValue NVARCHAR(21) = '',
    @ToCurrentBookValue NVARCHAR(21) = '',
    @FromPurchasePrice NVARCHAR(21) = '',
    @ToPurchasePrice NVARCHAR(21) = '',
    @FromSalvageValue NVARCHAR(21) = '',
    @ToSalvageValue NVARCHAR(21) = '',
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
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Asset';

    -- Set final values.
    SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        -- Non-nullable columns with default values.
        CreatedAt,
        Id,
        -- Non-nullable foreign keys.
        EmployeeId,
        LocationId,
        ProductId,
        -- Nullable foreign keys.
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
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@EmployeeID, EmployeeID) = 1
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@LocationId, LocationId) = 1
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@ProductId, ProductId) = 1
        -- Nullable foreign keys.
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@VendorId, VendorId) = 1
        -- Nullable columns.
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@DocumentationUrl, DocumentationUrl) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@SerialNumber, SerialNumber) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@WarrantyUnitOfMeasure, WarrantyUnitOfMeasure) = 1
        -- INT range parameters.
        AND [dbo].[udf_IsBetweenInts](@FromUsefulLife, UsefulLife, @ToUsefulLife) = 1
        AND [dbo].[udf_IsBetweenInts](@FromWarrantyDuration, WarrantyDuration, @ToWarrantyDuration) = 1
        -- DECIMAL(19, 4) range parameters.
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
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
