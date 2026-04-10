CREATE PROCEDURE [dbo].[usp_ReadAsset]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    -- 
    @ProductId UNIQUEIDENTIFIER = NULL,
    @LocationId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    -- 
    @VendorId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @SerialNumber NVARCHAR(842) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @WarrantyUnitOfMeasure NCHAR(2) = '',
    -- 
    @FromWarrantyDuration INT = -2147483648,
    @ToWarrantyDuration INT = -2147483648,
    @FromUsefulLife INT = -2147483648,
    @ToUsefulLife INT = -2147483648,
    -- 
    @FromPurchasePrice DECIMAL(15, 4) = -99999999999.9999,
    @ToPurchasePrice DECIMAL(15, 4) = -99999999999.9999,
    @FromSalvageValue DECIMAL(15, 4) = -99999999999.9999,
    @ToSalvageValue DECIMAL(15, 4) = -99999999999.9999,
    @FromAnnualDepreciationExpense DECIMAL(15, 4) = -99999999999.9999,
    @ToAnnualDepreciationExpense DECIMAL(15, 4) = -99999999999.9999,
    @FromCurrentBookValue DECIMAL(15, 4) = -99999999999.9999,
    @ToCurrentBookValue DECIMAL(15, 4) = -99999999999.9999,
    -- 
    @FromPurchasedAt DATETIME2(3) = '1900-01-01T00:00:00.000Z',
    @ToPurchasedAt DATETIME2(3) = '1900-01-01T00:00:00.000Z',
    @FromWarrantyExpirationDate DATETIME2(3) = '1900-01-01T00:00:00.000Z',
    @ToWarrantyExpirationDate DATETIME2(3) = '1900-01-01T00:00:00.000Z',
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
    DECLARE @HasReadingAssetPermission BIT = (SELECT HasReadingAssetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

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

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NCHAR NCHAR(1) = (SELECT NULLISH_NCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DATETIMEOFFSET DATETIME2(3) = (SELECT NULLISH_DATETIMEOFFSET FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_INT INT = (SELECT NULLISH_INT FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DECIMAL DECIMAL(15, 4) = (SELECT NULLISH_DECIMAL FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NCHAR NCHAR(1) = (SELECT NON_NULLISH_NCHAR FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DATETIMEOFFSET DATETIME2(3) = (SELECT NON_NULLISH_DATETIMEOFFSET FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_INT INT = (SELECT NON_NULLISH_INT FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DECIMAL DECIMAL(15, 4) = (SELECT NON_NULLISH_DECIMAL FROM [dbo].[VI_NonNullishConstants]);

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
        AND VendorId IS NOT DISTINCT FROM IIF(@VendorId = @NULLISH_UNIQUEIDENTIFIER, VendorId, IIF(@VendorId = @NON_NULLISH_UNIQUEIDENTIFIER, COALESCE(VendorId, @NON_NULLISH_UNIQUEIDENTIFIER), @VendorId))
        AND (SerialNumber IS NOT DISTINCT FROM IIF(@SerialNumber = @NULLISH_NVARCHAR, SerialNumber, IIF(@SerialNumber = @NON_NULLISH_NVARCHAR, COALESCE(SerialNumber, @NON_NULLISH_NVARCHAR), @SerialNumber)) OR SerialNumber LIKE @SerialNumber)
        AND (DocumentationUrl IS NOT DISTINCT FROM IIF(@DocumentationUrl = @NULLISH_NVARCHAR, DocumentationUrl, IIF(@DocumentationUrl = @NON_NULLISH_NVARCHAR, COALESCE(DocumentationUrl, @NON_NULLISH_NVARCHAR), @DocumentationUrl)) OR DocumentationUrl LIKE @DocumentationUrl)
        AND (WarrantyUnitOfMeasure IS NOT DISTINCT FROM IIF(@WarrantyUnitOfMeasure = @NULLISH_NCHAR, WarrantyUnitOfMeasure, IIF(@WarrantyUnitOfMeasure = @NON_NULLISH_NCHAR, COALESCE(WarrantyUnitOfMeasure, @NON_NULLISH_NCHAR), @WarrantyUnitOfMeasure)) OR WarrantyUnitOfMeasure LIKE @WarrantyUnitOfMeasure)
        -- 
        AND (IIF(@FromWarrantyDuration IN (@NULLISH_INT, @NON_NULLISH_INT), WarrantyDuration, @FromWarrantyDuration) <= WarrantyDuration OR WarrantyDuration IS NOT DISTINCT FROM IIF(@FromWarrantyDuration = @NULLISH_INT OR @FromWarrantyDuration IS NULL, NULL, @NON_NULLISH_INT))
        AND (WarrantyDuration <= IIF(@ToWarrantyDuration IN (@NULLISH_INT, @NON_NULLISH_INT), WarrantyDuration, @ToWarrantyDuration) OR WarrantyDuration IS NOT DISTINCT FROM IIF(@ToWarrantyDuration = @NULLISH_INT OR @ToWarrantyDuration IS NULL, NULL, @NON_NULLISH_INT))
        AND (IIF(@FromUsefulLife IN (@NULLISH_INT, @NON_NULLISH_INT), UsefulLife, @FromUsefulLife) <= UsefulLife OR UsefulLife IS NOT DISTINCT FROM IIF(@FromUsefulLife = @NULLISH_INT OR @FromUsefulLife IS NULL, NULL, @NON_NULLISH_INT))
        AND (UsefulLife <= IIF(@ToUsefulLife IN (@NULLISH_INT, @NON_NULLISH_INT), UsefulLife, @ToUsefulLife) OR UsefulLife IS NOT DISTINCT FROM IIF(@ToUsefulLife = @NULLISH_INT OR @ToUsefulLife IS NULL, NULL, @NON_NULLISH_INT))
        -- 
        AND (IIF(@FromPurchasePrice IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), PurchasePrice, @FromPurchasePrice) <= PurchasePrice OR PurchasePrice IS NOT DISTINCT FROM IIF(@FromPurchasePrice = @NULLISH_DECIMAL OR @FromPurchasePrice IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (PurchasePrice <= IIF(@ToPurchasePrice IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), PurchasePrice, @ToPurchasePrice) OR PurchasePrice IS NOT DISTINCT FROM IIF(@ToPurchasePrice = @NULLISH_DECIMAL OR @ToPurchasePrice IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (IIF(@FromSalvageValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), SalvageValue, @FromSalvageValue) <= SalvageValue OR SalvageValue IS NOT DISTINCT FROM IIF(@FromSalvageValue = @NULLISH_DECIMAL OR @FromSalvageValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (SalvageValue <= IIF(@ToSalvageValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), SalvageValue, @ToSalvageValue) OR SalvageValue IS NOT DISTINCT FROM IIF(@ToSalvageValue = @NULLISH_DECIMAL OR @ToSalvageValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (IIF(@FromAnnualDepreciationExpense IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AnnualDepreciationExpense, @FromAnnualDepreciationExpense) <= AnnualDepreciationExpense OR AnnualDepreciationExpense IS NOT DISTINCT FROM IIF(@FromAnnualDepreciationExpense = @NULLISH_DECIMAL OR @FromAnnualDepreciationExpense IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (AnnualDepreciationExpense <= IIF(@ToAnnualDepreciationExpense IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AnnualDepreciationExpense, @ToAnnualDepreciationExpense) OR AnnualDepreciationExpense IS NOT DISTINCT FROM IIF(@ToAnnualDepreciationExpense = @NULLISH_DECIMAL OR @ToAnnualDepreciationExpense IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (IIF(@FromCurrentBookValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), CurrentBookValue, @FromCurrentBookValue) <= CurrentBookValue OR CurrentBookValue IS NOT DISTINCT FROM IIF(@FromCurrentBookValue = @NULLISH_DECIMAL OR @FromCurrentBookValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (CurrentBookValue <= IIF(@ToCurrentBookValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), CurrentBookValue, @ToCurrentBookValue) OR CurrentBookValue IS NOT DISTINCT FROM IIF(@ToCurrentBookValue = @NULLISH_DECIMAL OR @ToCurrentBookValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        -- 
        AND (IIF(@FromPurchasedAt IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), PurchasedAt, @FromPurchasedAt) <= PurchasedAt OR PurchasedAt IS NOT DISTINCT FROM IIF(@FromPurchasedAt = @NULLISH_DATETIMEOFFSET OR @FromPurchasedAt IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
        AND (PurchasedAt <= IIF(@ToPurchasedAt IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), PurchasedAt, @ToPurchasedAt) OR PurchasedAt IS NOT DISTINCT FROM IIF(@ToPurchasedAt = @NULLISH_DATETIMEOFFSET OR @ToPurchasedAt IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
        AND (IIF(@FromWarrantyExpirationDate IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), WarrantyExpirationDate, @FromWarrantyExpirationDate) <= WarrantyExpirationDate OR WarrantyExpirationDate IS NOT DISTINCT FROM IIF(@FromWarrantyExpirationDate = @NULLISH_DATETIMEOFFSET OR @FromWarrantyExpirationDate IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
        AND (WarrantyExpirationDate <= IIF(@ToWarrantyExpirationDate IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), WarrantyExpirationDate, @ToWarrantyExpirationDate) OR WarrantyExpirationDate IS NOT DISTINCT FROM IIF(@ToWarrantyExpirationDate = @NULLISH_DATETIMEOFFSET OR @ToWarrantyExpirationDate IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
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
