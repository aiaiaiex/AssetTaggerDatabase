CREATE PROCEDURE [dbo].[usp_ReadProduct]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @CategoryId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @ManufacturerId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @ModelNumber NVARCHAR(421) = '',
    @Name NVARCHAR(421) = '',
    -- DATETIME2(3) range parameters.
    @FromCreatedAt NVARCHAR(24) = '',
    @ToCreatedAt NVARCHAR(24) = '',
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
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Product';

    -- Set final values.
    SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        -- Non-nullable columns with default values.
        CreatedAt,
        Id,
        -- Non-nullable foreign keys.
        CategoryId,
        -- Nullable foreign keys.
        ManufacturerId,
        -- Nullable columns.
        DocumentationUrl,
        ModelNumber,
        Name
    FROM
        [dbo].[Product]
    WHERE
        -- Non-nullable columns with default values.
        [dbo].[udf_IsEqualToUniqueIdentifierColumn](@Id, Id) = 1
        -- Non-nullable foreign keys.
        [dbo].[udf_IsEqualToUniqueIdentifierColumn](@CategoryId, CategoryId) = 1
        -- Nullable foreign keys.
        AND [dbo].[udf_IsEqualToUniqueIdentifierColumn](@ManufacturerId, ManufacturerId) = 1
        -- Nullable columns.
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@DocumentationUrl, DocumentationUrl) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@ModelNumber, ModelNumber) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@Name, Name) = 1
        -- DATETIME2(3) range parameters.
        AND [dbo].[udf_IsDatetime2ColumnBetween](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
    ORDER BY
        -- Descending sort.
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'ModelNumber')) THEN ModelNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Name')) THEN Name END DESC,
        -- Ascending sort.
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'ModelNumber')) THEN ModelNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Name')) THEN Name END ASC
        -- Pagination.
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
