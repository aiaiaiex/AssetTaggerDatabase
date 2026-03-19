CREATE PROCEDURE [dbo].[usp_ReadProduct]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER = NULL,
    @ProductName NVARCHAR(421) = '',
    @ProductModelNumber NVARCHAR(421) = '',
    @ProductDocumentationURL NVARCHAR(4000) = '',
    @ManufacturerID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @CategoryID UNIQUEIDENTIFIER = NULL,
    @FromProductInsertDate DATETIME = NULL,
    @ToProductInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadProduct BIT = (SELECT ReadProduct FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadProduct IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadProduct = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Product!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);

    -- Run actual query.
    SELECT
        ProductID,
        ProductName,
        ProductModelNumber,
        ProductDocumentationURL,
        ManufacturerID,
        CategoryID,
        ProductInsertDate
    FROM
        [dbo].[Product]
    WHERE
        ProductID = ISNULL(@ProductID, ProductID)
        AND (ProductName IS NOT DISTINCT FROM IIF(@ProductName = @NULLISH_NVARCHAR, ProductName, IIF(@ProductName = @NON_NULLISH_NVARCHAR, ISNULL(ProductName, @NON_NULLISH_NVARCHAR), @ProductName)) OR ProductName LIKE @ProductName)
        AND (ProductModelNumber IS NOT DISTINCT FROM IIF(@ProductModelNumber = @NULLISH_NVARCHAR, ProductModelNumber, IIF(@ProductModelNumber = @NON_NULLISH_NVARCHAR, ISNULL(ProductModelNumber, @NON_NULLISH_NVARCHAR), @ProductModelNumber)) OR ProductModelNumber LIKE @ProductModelNumber)
        AND (ProductDocumentationURL IS NOT DISTINCT FROM IIF(@ProductDocumentationURL = @NULLISH_NVARCHAR, ProductDocumentationURL, IIF(@ProductDocumentationURL = @NON_NULLISH_NVARCHAR, ISNULL(ProductDocumentationURL, @NON_NULLISH_NVARCHAR), @ProductDocumentationURL)) OR ProductDocumentationURL LIKE @ProductDocumentationURL)
        AND ManufacturerID IS NOT DISTINCT FROM IIF(@ManufacturerID = @NULLISH_UNIQUEIDENTIFIER, ManufacturerID, IIF(@ManufacturerID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(ManufacturerID, @NON_NULLISH_UNIQUEIDENTIFIER), @ManufacturerID))
        AND CategoryID = ISNULL(@CategoryID, CategoryID)
        AND ISNULL(@FromProductInsertDate, ProductInsertDate) <= ProductInsertDate
        AND ProductInsertDate <= ISNULL(@ToProductInsertDate, ProductInsertDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN ProductNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN ProductNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
