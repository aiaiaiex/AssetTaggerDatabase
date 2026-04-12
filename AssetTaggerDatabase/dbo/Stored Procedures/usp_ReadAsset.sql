CREATE PROCEDURE [dbo].[usp_ReadAsset]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER = NULL,
    -- 
    @ProductId UNIQUEIDENTIFIER = NULL,
    @LocationId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    -- 
    @VendorId NVARCHAR(36) = '',
    @SerialNumber NVARCHAR(842) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @WarrantyUnitOfMeasure NVARCHAR(2) = '',
    -- 
    @FromWarrantyDuration NVARCHAR(11) = '',
    @ToWarrantyDuration NVARCHAR(11) = '',
    @FromUsefulLife NVARCHAR(11) = '',
    @ToUsefulLife NVARCHAR(11) = '',
    -- 
    @FromPurchasePrice NVARCHAR(17) = '',
    @ToPurchasePrice NVARCHAR(17) = '',
    @FromSalvageValue NVARCHAR(17) = '',
    @ToSalvageValue NVARCHAR(17) = '',
    @FromAnnualDepreciationExpense NVARCHAR(17) = '',
    @ToAnnualDepreciationExpense NVARCHAR(17) = '',
    @FromCurrentBookValue NVARCHAR(17) = '',
    @ToCurrentBookValue NVARCHAR(17) = '',
    -- 
    @FromPurchasedAt NVARCHAR(24) = '',
    @ToPurchasedAt NVARCHAR(24) = '',
    @FromWarrantyExpirationDate NVARCHAR(24) = '',
    @ToWarrantyExpirationDate NVARCHAR(24) = '',
    -- 
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    -- 
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Asset';

    -- Set final values.
    SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        Id,
        CreatedAt,
        ProductId,
        LocationId,
        EmployeeId,
        VendorId,
        PurchasedAt,
        PurchasePrice,
        SerialNumber,
        DocumentationUrl,
        WarrantyUnitOfMeasure,
        WarrantyDuration,
        UsefulLife,
        SalvageValue,
        WarrantyExpirationDate,
        AnnualDepreciationExpense,
        CurrentBookValue
    FROM
        [dbo].[Asset]
    WHERE
        Id = COALESCE(@Id, Id)
        -- 
        AND ProductId = COALESCE(@ProductId, ProductId)
        AND LocationId = COALESCE(@LocationId, LocationId)
        AND EmployeeId = COALESCE(@EmployeeId, EmployeeId)
        -- 
        AND [dbo].[udf_IsEqualToUniqueIdentifierColumn](@VendorId, VendorId) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@SerialNumber, SerialNumber) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@DocumentationUrl, DocumentationUrl) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@WarrantyUnitOfMeasure, WarrantyUnitOfMeasure) = 1
        -- 
        AND [dbo].[udf_IsIntColumnBetween](@FromWarrantyDuration, WarrantyDuration, @ToWarrantyDuration) = 1
        AND [dbo].[udf_IsIntColumnBetween](@FromUsefulLife, UsefulLife, @ToUsefulLife) = 1
        -- 
        AND [dbo].[udf_IsDecimalColumnBetween](@FromPurchasePrice, PurchasePrice, @ToPurchasePrice) = 1
        AND [dbo].[udf_IsDecimalColumnBetween](@FromSalvageValue, SalvageValue, @ToSalvageValue) = 1
        AND [dbo].[udf_IsDecimalColumnBetween](@FromAnnualDepreciationExpense, AnnualDepreciationExpense, @ToAnnualDepreciationExpense) = 1
        AND [dbo].[udf_IsDecimalColumnBetween](@FromCurrentBookValue, CurrentBookValue, @ToCurrentBookValue) = 1
        -- 
        AND [dbo].[udf_IsDatetime2ColumnBetween](@FromPurchasedAt, PurchasedAt, @ToPurchasedAt) = 1
        AND [dbo].[udf_IsDatetime2ColumnBetween](@FromWarrantyExpirationDate, WarrantyExpirationDate, @ToWarrantyExpirationDate) = 1
        -- 
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'PurchasedAt')) THEN PurchasedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'PurchasePrice')) THEN PurchasePrice END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'SerialNumber')) THEN SerialNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'WarrantyDuration')) THEN WarrantyDuration END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'WarrantyUnitOfMeasure')) THEN WarrantyUnitOfMeasure END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'UsefulLife')) THEN UsefulLife END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'SalvageValue')) THEN SalvageValue END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'WarrantyExpirationDate')) THEN WarrantyExpirationDate END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'AnnualDepreciationExpense')) THEN AnnualDepreciationExpense END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CurrentBookValue')) THEN CurrentBookValue END DESC,
        -- 
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'PurchasedAt')) THEN PurchasedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'PurchasePrice')) THEN PurchasePrice END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'SerialNumber')) THEN SerialNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'WarrantyDuration')) THEN WarrantyDuration END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'WarrantyUnitOfMeasure')) THEN WarrantyUnitOfMeasure END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'UsefulLife')) THEN UsefulLife END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'SalvageValue')) THEN SalvageValue END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'WarrantyExpirationDate')) THEN WarrantyExpirationDate END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'AnnualDepreciationExpense')) THEN AnnualDepreciationExpense END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CurrentBookValue')) THEN CurrentBookValue END ASC
        -- 
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
