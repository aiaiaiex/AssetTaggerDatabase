CREATE PROCEDURE [dbo].[usp_ReadAsset]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    -- 
    @ProductId UNIQUEIDENTIFIER = NULL,
    @LocationId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    -- 
    @VendorId NVARCHAR(36) = '',
    @SerialNumber NVARCHAR(842) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @WarrantyUnitOfMeasure NCHAR(2) = '',
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
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingAssetPermission BIT = (SELECT HasReadingAssetPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingAssetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingAssetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Asset!', 11, 0);
            RETURN -1;
        END;

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
        OFFSET COALESCE(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT COALESCE(@RowsToReturn, 2147483647) ROWS ONLY;
END;
