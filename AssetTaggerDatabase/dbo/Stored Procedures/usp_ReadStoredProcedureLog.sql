CREATE PROCEDURE [dbo].[usp_ReadStoredProcedureLog]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @EndUserId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Arguments NVARCHAR(MAX) = '',
    @HasExecutedSuccessfully NVARCHAR(1) = '',
    @Name NVARCHAR(4000) = '',
    -- Nullable columns.
    @EndUserIpAddress NVARCHAR(4000) = '',
    -- BIGINT range parameters.
    @FromExecutionTimeInMilliseconds NVARCHAR(19) = '',
    @ToExecutionTimeInMilliseconds NVARCHAR(19) = '',
    -- DATETIME2(3) range parameters.
    @FromEndedAt NVARCHAR(24) = '',
    @ToEndedAt NVARCHAR(24) = '',
    @FromStartedAt NVARCHAR(24) = '',
    @ToStartedAt NVARCHAR(24) = '',
    -- Sort parameters.
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = '',
    -- Pagination parameters.
    @RowsToSkip NVARCHAR(19) = '',
    @RowsToReturn NVARCHAR(19) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'StoredProcedureLog';

    -- Set final values.
    SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        -- Non-nullable columns with default values.
        Id,
        -- Nullable foreign keys.
        EndUserId,
        -- Non-nullable columns.
        Arguments,
        EndedAt,
        HasExecutedSuccessfully,
        Name,
        StartedAt,
        -- Nullable columns.
        EndUserIpAddress,
        -- Computed columns.
        ExecutionTimeInMilliseconds
    FROM
        [dbo].[StoredProcedureLog]
    WHERE
        -- Non-nullable columns with default values.
        [dbo].[udf_IsEqualToUniqueIdentifierColumn](@Id, Id) = 1
        -- Nullable foreign keys.
        AND [dbo].[udf_IsEqualToUniqueIdentifierColumn](@EndUserId, EndUserId) = 1
        -- Non-nullable columns.
        AND [dbo].[udf_IsEqualToOrLikeNvarcharMaxColumn](@Arguments, Arguments) = 1
        AND [dbo].[udf_IsEqualToBitColumn](@HasExecutedSuccessfully, HasExecutedSuccessfully) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@Name, Name) = 1
        -- Nullable columns.
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@EndUserIpAddress, EndUserIpAddress) = 1
        -- BIGINT range parameters.
        AND [dbo].[udf_IsBetweenBigints](@FromExecutionTimeInMilliseconds, ExecutionTimeInMilliseconds, @ToExecutionTimeInMilliseconds) = 1
        -- DATETIME2(3) range parameters.
        AND [dbo].[udf_IsBetweenDatetime2s](@FromEndedAt, EndedAt, @ToEndedAt) = 1
        AND [dbo].[udf_IsBetweenDatetime2s](@FromStartedAt, StartedAt, @ToStartedAt) = 1
    ORDER BY
        -- Descending sort.
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Arguments')) THEN Arguments END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'EndedAt')) THEN EndedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasExecutedSuccessfully')) THEN HasExecutedSuccessfully END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Name')) THEN Name END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'StartedAt')) THEN StartedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'EndUserIpAddress')) THEN EndUserIpAddress END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'ExecutionTimeInMilliseconds')) THEN ExecutionTimeInMilliseconds END DESC,
        -- Ascending sort.
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Arguments')) THEN Arguments END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'EndedAt')) THEN EndedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasExecutedSuccessfully')) THEN HasExecutedSuccessfully END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Name')) THEN Name END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'StartedAt')) THEN StartedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'EndUserIpAddress')) THEN EndUserIpAddress END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'ExecutionTimeInMilliseconds')) THEN ExecutionTimeInMilliseconds END ASC
        -- Pagination.
        OFFSET [dbo].[udf_GetRowsToSkipInBigint](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInBigint](@RowsToReturn) ROWS ONLY;
END;
