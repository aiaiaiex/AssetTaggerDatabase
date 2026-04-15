CREATE PROCEDURE [dbo].[usp_ReadStoredProcedureLog]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @EndUserId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Arguments NVARCHAR(MAX) = '',
    @HasExecutedSuccessfully NVARCHAR(1) = '',
    @Operation NVARCHAR(6) = '',
    @TableName NVARCHAR(4000) = '',
    -- Nullable columns.
    @EndUserIpAddress NVARCHAR(4000) = '',
    @ErrorMessage NVARCHAR(4000) = '',
    -- INT range parameters.
    @FromErrorNumber NVARCHAR(11) = '',
    @ToErrorNumber NVARCHAR(11) = '',
    -- BIGINT range parameters.
    @FromExecutionTimeInMilliseconds NVARCHAR(20) = '',
    @ToExecutionTimeInMilliseconds NVARCHAR(20) = '',
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
        Operation,
        StartedAt,
        TableName,
        -- Nullable columns.
        EndUserIpAddress,
        ErrorMessage,
        ErrorNumber,
        -- Computed columns.
        ExecutionTimeInMilliseconds
    FROM
        [dbo].[StoredProcedureLog]
    WHERE
        -- Non-nullable columns with default values.
        [dbo].[udf_IsEqualToUniqueIdentifier](@Id, Id) = 1
        -- Nullable foreign keys.
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@EndUserId, EndUserId) = 1
        -- Non-nullable columns.
        AND [dbo].[udf_IsEqualToOrLikeNvarcharMax](@Arguments, Arguments) = 1
        AND [dbo].[udf_IsEqualToBit](@HasExecutedSuccessfully, HasExecutedSuccessfully) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@Operation, Operation) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@TableName, TableName) = 1
        -- Nullable columns.
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@EndUserIpAddress, EndUserIpAddress) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@ErrorMessage, ErrorMessage) = 1
        -- INT range parameters.
        AND [dbo].[udf_IsBetweenInts](@FromErrorNumber, ErrorNumber, @ToErrorNumber) = 1
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
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Operation')) THEN Operation END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'StartedAt')) THEN StartedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'TableName')) THEN TableName END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'EndUserIpAddress')) THEN EndUserIpAddress END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'ErrorMessage')) THEN ErrorMessage END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'ErrorNumber')) THEN ErrorNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'ExecutionTimeInMilliseconds')) THEN ExecutionTimeInMilliseconds END DESC,
        -- Ascending sort.
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Arguments')) THEN Arguments END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'EndedAt')) THEN EndedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasExecutedSuccessfully')) THEN HasExecutedSuccessfully END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Operation')) THEN Operation END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'StartedAt')) THEN StartedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'TableName')) THEN TableName END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'EndUserIpAddress')) THEN EndUserIpAddress END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'ErrorMessage')) THEN ErrorMessage END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'ErrorNumber')) THEN ErrorNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'ExecutionTimeInMilliseconds')) THEN ExecutionTimeInMilliseconds END ASC
        -- Pagination.
        OFFSET [dbo].[udf_GetRowsToSkipInBigint](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInBigint](@RowsToReturn) ROWS ONLY;
END;
