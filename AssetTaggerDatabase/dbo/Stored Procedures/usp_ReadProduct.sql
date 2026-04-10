CREATE PROCEDURE [dbo].[usp_ReadProduct]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(421) = '',
    @ModelNumber NVARCHAR(421) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @ManufacturerId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @CategoryId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingProductPermission BIT = (SELECT HasReadingProductPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

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
        Id = COALESCE(@Id, Id)
        AND (Name IS NOT DISTINCT FROM IIF(@Name = @NULLISH_NVARCHAR, Name, IIF(@Name = @NON_NULLISH_NVARCHAR, COALESCE(Name, @NON_NULLISH_NVARCHAR), @Name)) OR Name LIKE @Name)
        AND (ModelNumber IS NOT DISTINCT FROM IIF(@ModelNumber = @NULLISH_NVARCHAR, ModelNumber, IIF(@ModelNumber = @NON_NULLISH_NVARCHAR, COALESCE(ModelNumber, @NON_NULLISH_NVARCHAR), @ModelNumber)) OR ModelNumber LIKE @ModelNumber)
        AND (DocumentationUrl IS NOT DISTINCT FROM IIF(@DocumentationUrl = @NULLISH_NVARCHAR, DocumentationUrl, IIF(@DocumentationUrl = @NON_NULLISH_NVARCHAR, COALESCE(DocumentationUrl, @NON_NULLISH_NVARCHAR), @DocumentationUrl)) OR DocumentationUrl LIKE @DocumentationUrl)
        AND ManufacturerId IS NOT DISTINCT FROM IIF(@ManufacturerId = @NULLISH_UNIQUEIDENTIFIER, ManufacturerId, IIF(@ManufacturerId = @NON_NULLISH_UNIQUEIDENTIFIER, COALESCE(ManufacturerId, @NON_NULLISH_UNIQUEIDENTIFIER), @ManufacturerId))
        AND CategoryId = COALESCE(@CategoryId, CategoryId)
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
