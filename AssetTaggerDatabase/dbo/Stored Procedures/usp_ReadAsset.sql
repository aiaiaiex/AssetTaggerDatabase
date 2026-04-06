CREATE PROCEDURE [dbo].[usp_ReadAsset]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetID UNIQUEIDENTIFIER = NULL,
    -- 
    @ProductID UNIQUEIDENTIFIER = NULL,
    @LocationID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    -- 
    @VendorID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @AssetSerialNumber NVARCHAR(842) = '',
    @AssetDocumentationURL NVARCHAR(4000) = '',
    @AssetWarrantyUnitOfMeasure NCHAR(2) = '',
    -- 
    @FromAssetWarrantyDuration INT = -2147483648,
    @ToAssetWarrantyDuration INT = -2147483648,
    @FromAssetUsefulLife INT = -2147483648,
    @ToAssetUsefulLife INT = -2147483648,
    -- 
    @FromAssetPurchasePrice DECIMAL(15, 4) = -99999999999.9999,
    @ToAssetPurchasePrice DECIMAL(15, 4) = -99999999999.9999,
    @FromAssetSalvageValue DECIMAL(15, 4) = -99999999999.9999,
    @ToAssetSalvageValue DECIMAL(15, 4) = -99999999999.9999,
    @FromAssetAnnualDepreciationExpense DECIMAL(15, 4) = -99999999999.9999,
    @ToAssetAnnualDepreciationExpense DECIMAL(15, 4) = -99999999999.9999,
    @FromAssetCurrentBookValue DECIMAL(15, 4) = -99999999999.9999,
    @ToAssetCurrentBookValue DECIMAL(15, 4) = -99999999999.9999,
    -- 
    @FromAssetPurchaseDate DATETIMEOFFSET(3) = '1900-01-01T00:00:00.000Z',
    @ToAssetPurchaseDate DATETIMEOFFSET(3) = '1900-01-01T00:00:00.000Z',
    @FromAssetWarrantyExpirationDate DATETIMEOFFSET(3) = '1900-01-01T00:00:00.000Z',
    @ToAssetWarrantyExpirationDate DATETIMEOFFSET(3) = '1900-01-01T00:00:00.000Z',
    -- 
    @FromAssetTagDate DATETIMEOFFSET(3) = NULL,
    @ToAssetTagDate DATETIMEOFFSET(3) = NULL,
    -- 
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingAssetPermission BIT = (SELECT HasReadingAssetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasReadingAssetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingAssetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Asset!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NCHAR NCHAR(1) = (SELECT NULLISH_NCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DATETIMEOFFSET DATETIMEOFFSET(3) = (SELECT NULLISH_DATETIMEOFFSET FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_INT INT = (SELECT NULLISH_INT FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DECIMAL DECIMAL(15, 4) = (SELECT NULLISH_DECIMAL FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NCHAR NCHAR(1) = (SELECT NON_NULLISH_NCHAR FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DATETIMEOFFSET DATETIMEOFFSET(3) = (SELECT NON_NULLISH_DATETIMEOFFSET FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_INT INT = (SELECT NON_NULLISH_INT FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DECIMAL DECIMAL(15, 4) = (SELECT NON_NULLISH_DECIMAL FROM [dbo].[VI_NonNullishConstants]);

    -- Run actual query.
    SELECT
        AssetID,
        AssetTagDate,
        ProductID,
        LocationID,
        EmployeeID,
        VendorID,
        AssetPurchaseDate,
        AssetPurchasePrice,
        AssetSerialNumber,
        AssetDocumentationURL,
        AssetWarrantyUnitOfMeasure,
        AssetWarrantyDuration,
        AssetUsefulLife,
        AssetSalvageValue,
        AssetWarrantyExpirationDate,
        AssetAnnualDepreciationExpense,
        AssetCurrentBookValue
    FROM
        [dbo].[Asset]
    WHERE
        AssetID = ISNULL(@AssetID, AssetID)
        -- 
        AND ProductID = ISNULL(@ProductID, ProductID)
        AND LocationID = ISNULL(@LocationID, LocationID)
        AND EmployeeID = ISNULL(@EmployeeID, EmployeeID)
        -- 
        AND VendorID IS NOT DISTINCT FROM IIF(@VendorID = @NULLISH_UNIQUEIDENTIFIER, VendorID, IIF(@VendorID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(VendorID, @NON_NULLISH_UNIQUEIDENTIFIER), @VendorID))
        AND (AssetSerialNumber IS NOT DISTINCT FROM IIF(@AssetSerialNumber = @NULLISH_NVARCHAR, AssetSerialNumber, IIF(@AssetSerialNumber = @NON_NULLISH_NVARCHAR, ISNULL(AssetSerialNumber, @NON_NULLISH_NVARCHAR), @AssetSerialNumber)) OR AssetSerialNumber LIKE @AssetSerialNumber)
        AND (AssetDocumentationURL IS NOT DISTINCT FROM IIF(@AssetDocumentationURL = @NULLISH_NVARCHAR, AssetDocumentationURL, IIF(@AssetDocumentationURL = @NON_NULLISH_NVARCHAR, ISNULL(AssetDocumentationURL, @NON_NULLISH_NVARCHAR), @AssetDocumentationURL)) OR AssetDocumentationURL LIKE @AssetDocumentationURL)
        AND (AssetWarrantyUnitOfMeasure IS NOT DISTINCT FROM IIF(@AssetWarrantyUnitOfMeasure = @NULLISH_NCHAR, AssetWarrantyUnitOfMeasure, IIF(@AssetWarrantyUnitOfMeasure = @NON_NULLISH_NCHAR, ISNULL(AssetWarrantyUnitOfMeasure, @NON_NULLISH_NCHAR), @AssetWarrantyUnitOfMeasure)) OR AssetWarrantyUnitOfMeasure LIKE @AssetWarrantyUnitOfMeasure)
        -- 
        AND (IIF(@FromAssetWarrantyDuration IN (@NULLISH_INT, @NON_NULLISH_INT), AssetWarrantyDuration, @FromAssetWarrantyDuration) <= AssetWarrantyDuration OR AssetWarrantyDuration IS NOT DISTINCT FROM IIF(@FromAssetWarrantyDuration = @NULLISH_INT OR @FromAssetWarrantyDuration IS NULL, NULL, @NON_NULLISH_INT))
        AND (AssetWarrantyDuration <= IIF(@ToAssetWarrantyDuration IN (@NULLISH_INT, @NON_NULLISH_INT), AssetWarrantyDuration, @ToAssetWarrantyDuration) OR AssetWarrantyDuration IS NOT DISTINCT FROM IIF(@ToAssetWarrantyDuration = @NULLISH_INT OR @ToAssetWarrantyDuration IS NULL, NULL, @NON_NULLISH_INT))
        AND (IIF(@FromAssetUsefulLife IN (@NULLISH_INT, @NON_NULLISH_INT), AssetUsefulLife, @FromAssetUsefulLife) <= AssetUsefulLife OR AssetUsefulLife IS NOT DISTINCT FROM IIF(@FromAssetUsefulLife = @NULLISH_INT OR @FromAssetUsefulLife IS NULL, NULL, @NON_NULLISH_INT))
        AND (AssetUsefulLife <= IIF(@ToAssetUsefulLife IN (@NULLISH_INT, @NON_NULLISH_INT), AssetUsefulLife, @ToAssetUsefulLife) OR AssetUsefulLife IS NOT DISTINCT FROM IIF(@ToAssetUsefulLife = @NULLISH_INT OR @ToAssetUsefulLife IS NULL, NULL, @NON_NULLISH_INT))
        -- 
        AND (IIF(@FromAssetPurchasePrice IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetPurchasePrice, @FromAssetPurchasePrice) <= AssetPurchasePrice OR AssetPurchasePrice IS NOT DISTINCT FROM IIF(@FromAssetPurchasePrice = @NULLISH_DECIMAL OR @FromAssetPurchasePrice IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (AssetPurchasePrice <= IIF(@ToAssetPurchasePrice IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetPurchasePrice, @ToAssetPurchasePrice) OR AssetPurchasePrice IS NOT DISTINCT FROM IIF(@ToAssetPurchasePrice = @NULLISH_DECIMAL OR @ToAssetPurchasePrice IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (IIF(@FromAssetSalvageValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetSalvageValue, @FromAssetSalvageValue) <= AssetSalvageValue OR AssetSalvageValue IS NOT DISTINCT FROM IIF(@FromAssetSalvageValue = @NULLISH_DECIMAL OR @FromAssetSalvageValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (AssetSalvageValue <= IIF(@ToAssetSalvageValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetSalvageValue, @ToAssetSalvageValue) OR AssetSalvageValue IS NOT DISTINCT FROM IIF(@ToAssetSalvageValue = @NULLISH_DECIMAL OR @ToAssetSalvageValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (IIF(@FromAssetAnnualDepreciationExpense IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetAnnualDepreciationExpense, @FromAssetAnnualDepreciationExpense) <= AssetAnnualDepreciationExpense OR AssetAnnualDepreciationExpense IS NOT DISTINCT FROM IIF(@FromAssetAnnualDepreciationExpense = @NULLISH_DECIMAL OR @FromAssetAnnualDepreciationExpense IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (AssetAnnualDepreciationExpense <= IIF(@ToAssetAnnualDepreciationExpense IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetAnnualDepreciationExpense, @ToAssetAnnualDepreciationExpense) OR AssetAnnualDepreciationExpense IS NOT DISTINCT FROM IIF(@ToAssetAnnualDepreciationExpense = @NULLISH_DECIMAL OR @ToAssetAnnualDepreciationExpense IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (IIF(@FromAssetCurrentBookValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetCurrentBookValue, @FromAssetCurrentBookValue) <= AssetCurrentBookValue OR AssetCurrentBookValue IS NOT DISTINCT FROM IIF(@FromAssetCurrentBookValue = @NULLISH_DECIMAL OR @FromAssetCurrentBookValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        AND (AssetCurrentBookValue <= IIF(@ToAssetCurrentBookValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetCurrentBookValue, @ToAssetCurrentBookValue) OR AssetCurrentBookValue IS NOT DISTINCT FROM IIF(@ToAssetCurrentBookValue = @NULLISH_DECIMAL OR @ToAssetCurrentBookValue IS NULL, NULL, @NON_NULLISH_DECIMAL))
        -- 
        AND (IIF(@FromAssetPurchaseDate IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), AssetPurchaseDate, @FromAssetPurchaseDate) <= AssetPurchaseDate OR AssetPurchaseDate IS NOT DISTINCT FROM IIF(@FromAssetPurchaseDate = @NULLISH_DATETIMEOFFSET OR @FromAssetPurchaseDate IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
        AND (AssetPurchaseDate <= IIF(@ToAssetPurchaseDate IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), AssetPurchaseDate, @ToAssetPurchaseDate) OR AssetPurchaseDate IS NOT DISTINCT FROM IIF(@ToAssetPurchaseDate = @NULLISH_DATETIMEOFFSET OR @ToAssetPurchaseDate IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
        AND (IIF(@FromAssetWarrantyExpirationDate IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), AssetWarrantyExpirationDate, @FromAssetWarrantyExpirationDate) <= AssetWarrantyExpirationDate OR AssetWarrantyExpirationDate IS NOT DISTINCT FROM IIF(@FromAssetWarrantyExpirationDate = @NULLISH_DATETIMEOFFSET OR @FromAssetWarrantyExpirationDate IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
        AND (AssetWarrantyExpirationDate <= IIF(@ToAssetWarrantyExpirationDate IN (@NULLISH_DATETIMEOFFSET, @NON_NULLISH_DATETIMEOFFSET), AssetWarrantyExpirationDate, @ToAssetWarrantyExpirationDate) OR AssetWarrantyExpirationDate IS NOT DISTINCT FROM IIF(@ToAssetWarrantyExpirationDate = @NULLISH_DATETIMEOFFSET OR @ToAssetWarrantyExpirationDate IS NULL, NULL, @NON_NULLISH_DATETIMEOFFSET))
        -- 
        AND ISNULL(@FromAssetTagDate, AssetTagDate) <= AssetTagDate
        AND AssetTagDate <= ISNULL(@ToAssetTagDate, AssetTagDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN AssetNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN AssetNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
