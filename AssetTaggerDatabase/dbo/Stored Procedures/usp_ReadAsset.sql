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
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Asset';

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
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
