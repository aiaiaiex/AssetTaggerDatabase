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
    @AssetWarrantyUnitOfMeasure NCHAR(2) = '',
    -- 
    @FromAssetWarrantyDuration INT = -2147483648,
    @ToAssetWarrantyDuration INT = -2147483648,
    @FromAssetUsefulLife INT = -2147483648,
    @ToAssetUsefulLife INT = -2147483648,
    -- 
    @FromAssetPurchasePrice DECIMAL(19, 4) = -999999999999999.9999,
    @ToAssetPurchasePrice DECIMAL(19, 4) = -999999999999999.9999,
    @FromAssetSalvageValue DECIMAL(19, 4) = -999999999999999.9999,
    @ToAssetSalvageValue DECIMAL(19, 4) = -999999999999999.9999,
    @FromAssetAnnualDepreciationExpense DECIMAL(19, 4) = -999999999999999.9999,
    @ToAssetAnnualDepreciationExpense DECIMAL(19, 4) = -999999999999999.9999,
    @FromAssetCurrentBookValue DECIMAL(19, 4) = -999999999999999.9999,
    @ToAssetCurrentBookValue DECIMAL(19, 4) = -999999999999999.9999,
    -- 
    @FromAssetPurchaseDate DATETIME = '1753-01-01 00:00:00.000',
    @ToAssetPurchaseDate DATETIME = '1753-01-01 00:00:00.000',
    @FromAssetWarrantyExpirationDate DATETIME = '1753-01-01 00:00:00.000',
    @ToAssetWarrantyExpirationDate DATETIME = '1753-01-01 00:00:00.000',
    -- 
    @FromAssetTagDate DATETIME = NULL,
    @ToAssetTagDate DATETIME = NULL,
    -- 
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadAsset BIT = (SELECT ReadAsset FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadAsset IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadAsset = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Asset!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NCHAR NCHAR(1) = (SELECT NULLISH_NCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DATETIME DATETIME = (SELECT NULLISH_DATETIME FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_INT INT = (SELECT NULLISH_INT FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DECIMAL DECIMAL(19, 4) = (SELECT NULLISH_DECIMAL FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NCHAR NCHAR(1) = (SELECT NON_NULLISH_NCHAR FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DATETIME DATETIME = (SELECT NON_NULLISH_DATETIME FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_INT INT = (SELECT NON_NULLISH_INT FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DECIMAL DECIMAL(19, 4) = (SELECT NON_NULLISH_DECIMAL FROM [dbo].[VI_NonNullishConstants]);

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
        AND (AssetWarrantyUnitOfMeasure IS NOT DISTINCT FROM IIF(@AssetWarrantyUnitOfMeasure = @NULLISH_NCHAR, AssetWarrantyUnitOfMeasure, IIF(@AssetWarrantyUnitOfMeasure = @NON_NULLISH_NCHAR, ISNULL(AssetWarrantyUnitOfMeasure, @NON_NULLISH_NCHAR), @AssetWarrantyUnitOfMeasure)) OR AssetWarrantyUnitOfMeasure LIKE @AssetWarrantyUnitOfMeasure)
        -- 
        AND (IIF(@FromAssetWarrantyDuration IN (@NULLISH_INT, @NON_NULLISH_INT), AssetWarrantyDuration, @FromAssetWarrantyDuration) <= AssetWarrantyDuration OR AssetWarrantyDuration IS NOT DISTINCT FROM IIF(@FromAssetWarrantyDuration = @NON_NULLISH_INT, @NON_NULLISH_INT, NULL))
        AND (AssetWarrantyDuration <= IIF(@ToAssetWarrantyDuration IN (@NULLISH_INT, @NON_NULLISH_INT), AssetWarrantyDuration, @ToAssetWarrantyDuration) OR AssetWarrantyDuration IS NOT DISTINCT FROM IIF(@ToAssetWarrantyDuration = @NON_NULLISH_INT, @NON_NULLISH_INT, NULL))
        AND (IIF(@FromAssetUsefulLife IN (@NULLISH_INT, @NON_NULLISH_INT), AssetUsefulLife, @FromAssetUsefulLife) <= AssetUsefulLife OR AssetUsefulLife IS NOT DISTINCT FROM IIF(@FromAssetUsefulLife = @NON_NULLISH_INT, @NON_NULLISH_INT, NULL))
        AND (AssetUsefulLife <= IIF(@ToAssetUsefulLife IN (@NULLISH_INT, @NON_NULLISH_INT), AssetUsefulLife, @ToAssetUsefulLife) OR AssetUsefulLife IS NOT DISTINCT FROM IIF(@ToAssetUsefulLife = @NON_NULLISH_INT, @NON_NULLISH_INT, NULL))
        -- 
        AND (IIF(@FromAssetPurchasePrice IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetPurchasePrice, @FromAssetPurchasePrice) <= AssetPurchasePrice OR AssetPurchasePrice IS NOT DISTINCT FROM IIF(@FromAssetPurchasePrice = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (AssetPurchasePrice <= IIF(@ToAssetPurchasePrice IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetPurchasePrice, @ToAssetPurchasePrice) OR AssetPurchasePrice IS NOT DISTINCT FROM IIF(@ToAssetPurchasePrice = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (IIF(@FromAssetSalvageValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetSalvageValue, @FromAssetSalvageValue) <= AssetSalvageValue OR AssetSalvageValue IS NOT DISTINCT FROM IIF(@FromAssetSalvageValue = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (AssetSalvageValue <= IIF(@ToAssetSalvageValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetSalvageValue, @ToAssetSalvageValue) OR AssetSalvageValue IS NOT DISTINCT FROM IIF(@ToAssetSalvageValue = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (IIF(@FromAssetAnnualDepreciationExpense IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetAnnualDepreciationExpense, @FromAssetAnnualDepreciationExpense) <= AssetAnnualDepreciationExpense OR AssetAnnualDepreciationExpense IS NOT DISTINCT FROM IIF(@FromAssetAnnualDepreciationExpense = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (AssetAnnualDepreciationExpense <= IIF(@ToAssetAnnualDepreciationExpense IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetAnnualDepreciationExpense, @ToAssetAnnualDepreciationExpense) OR AssetAnnualDepreciationExpense IS NOT DISTINCT FROM IIF(@ToAssetAnnualDepreciationExpense = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (IIF(@FromAssetCurrentBookValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetCurrentBookValue, @FromAssetCurrentBookValue) <= AssetCurrentBookValue OR AssetCurrentBookValue IS NOT DISTINCT FROM IIF(@FromAssetCurrentBookValue = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (AssetCurrentBookValue <= IIF(@ToAssetCurrentBookValue IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetCurrentBookValue, @ToAssetCurrentBookValue) OR AssetCurrentBookValue IS NOT DISTINCT FROM IIF(@ToAssetCurrentBookValue = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        -- 
        AND (IIF(@FromAssetPurchaseDate IN (@NULLISH_DATETIME, @NON_NULLISH_DATETIME), AssetPurchaseDate, @FromAssetPurchaseDate) <= AssetPurchaseDate OR AssetPurchaseDate IS NOT DISTINCT FROM IIF(@FromAssetPurchaseDate = @NON_NULLISH_DATETIME, @NON_NULLISH_DATETIME, NULL))
        AND (AssetPurchaseDate <= IIF(@ToAssetPurchaseDate IN (@NULLISH_DATETIME, @NON_NULLISH_DATETIME), AssetPurchaseDate, @ToAssetPurchaseDate) OR AssetPurchaseDate IS NOT DISTINCT FROM IIF(@ToAssetPurchaseDate = @NON_NULLISH_DATETIME, @NON_NULLISH_DATETIME, NULL))
        AND (IIF(@FromAssetWarrantyExpirationDate IN (@NULLISH_DATETIME, @NON_NULLISH_DATETIME), AssetWarrantyExpirationDate, @FromAssetWarrantyExpirationDate) <= AssetWarrantyExpirationDate OR AssetWarrantyExpirationDate IS NOT DISTINCT FROM IIF(@FromAssetWarrantyExpirationDate = @NON_NULLISH_DATETIME, @NON_NULLISH_DATETIME, NULL))
        AND (AssetWarrantyExpirationDate <= IIF(@ToAssetWarrantyExpirationDate IN (@NULLISH_DATETIME, @NON_NULLISH_DATETIME), AssetWarrantyExpirationDate, @ToAssetWarrantyExpirationDate) OR AssetWarrantyExpirationDate IS NOT DISTINCT FROM IIF(@ToAssetWarrantyExpirationDate = @NON_NULLISH_DATETIME, @NON_NULLISH_DATETIME, NULL))
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
