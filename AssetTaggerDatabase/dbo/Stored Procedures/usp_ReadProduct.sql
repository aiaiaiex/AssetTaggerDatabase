CREATE PROCEDURE [dbo].[usp_ReadProduct]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(421) = '',
    @ModelNumber NVARCHAR(421) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @ManufacturerId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @CategoryId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIMEOFFSET(3) = NULL,
    @ToCreatedAt DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingProductPermission BIT = (SELECT HasReadingProductPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingProductPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingProductPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Product!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);

    -- Run actual query.
    SELECT
        Id,
        Name,
        ModelNumber,
        DocumentationUrl,
        ManufacturerId,
        CategoryId,
        CreatedAt
    FROM
        [dbo].[Product]
    WHERE
        Id = ISNULL(@Id, Id)
        AND (Name IS NOT DISTINCT FROM IIF(@Name = @NULLISH_NVARCHAR, Name, IIF(@Name = @NON_NULLISH_NVARCHAR, ISNULL(Name, @NON_NULLISH_NVARCHAR), @Name)) OR Name LIKE @Name)
        AND (ModelNumber IS NOT DISTINCT FROM IIF(@ModelNumber = @NULLISH_NVARCHAR, ModelNumber, IIF(@ModelNumber = @NON_NULLISH_NVARCHAR, ISNULL(ModelNumber, @NON_NULLISH_NVARCHAR), @ModelNumber)) OR ModelNumber LIKE @ModelNumber)
        AND (DocumentationUrl IS NOT DISTINCT FROM IIF(@DocumentationUrl = @NULLISH_NVARCHAR, DocumentationUrl, IIF(@DocumentationUrl = @NON_NULLISH_NVARCHAR, ISNULL(DocumentationUrl, @NON_NULLISH_NVARCHAR), @DocumentationUrl)) OR DocumentationUrl LIKE @DocumentationUrl)
        AND ManufacturerId IS NOT DISTINCT FROM IIF(@ManufacturerId = @NULLISH_UNIQUEIDENTIFIER, ManufacturerId, IIF(@ManufacturerId = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(ManufacturerId, @NON_NULLISH_UNIQUEIDENTIFIER), @ManufacturerId))
        AND CategoryId = ISNULL(@CategoryId, CategoryId)
        AND ISNULL(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= ISNULL(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
