CREATE PROCEDURE [dbo].[usp_ReadProductSet]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @ParentProductId NVARCHAR(36) = '',
    @ProductId NVARCHAR(36) = '',
    -- INT range parameters.
    @FromProductQuantity NVARCHAR(10) = '',
    @ToProductQuantity NVARCHAR(10) = '',
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
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'ProductSet';

    -- Set final values.
    SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        -- Non-nullable columns with default values.
        CreatedAt,
        ProductQuantity,
        -- Non-nullable foreign keys.
        ParentProductId,
        ProductId
    FROM
        [dbo].[ProductSet]
    WHERE
        -- Non-nullable foreign keys.
        [dbo].[udf_IsEqualToUniqueIdentifierColumn](@ParentProductId, ParentProductId) = 1
        AND [dbo].[udf_IsEqualToUniqueIdentifierColumn](@ProductId, ProductId) = 1
        -- INT range parameters.
        AND [dbo].[udf_IsBetweenInts](@FromProductQuantity, ProductQuantity, @ToProductQuantity) = 1
        -- DATETIME2(3) range parameters.
        AND [dbo].[udf_IsBetweenDatetime2s](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
    ORDER BY
        -- Descending sort.
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'ProductQuantity')) THEN ProductQuantity END DESC,
        -- Ascending sort.
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'ProductQuantity')) THEN ProductQuantity END ASC
        -- Pagination.
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
