CREATE PROCEDURE [dbo].[usp_ReadStoredProcedureLog]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER = NULL,
    @EndUserId NVARCHAR(36) = '',
    @EndUserIpAddress NVARCHAR(4000) = '',
    @HasExecutedSuccessfully BIT = NULL,
    @Name NVARCHAR(4000) = NULL,
    @Arguments NVARCHAR(MAX) = NULL,
    @FromStartedAt DATETIME2(3) = NULL,
    @ToStartedAt DATETIME2(3) = NULL,
    @FromEndedAt DATETIME2(3) = NULL,
    @ToEndedAt DATETIME2(3) = NULL,
    @FromExecutionTimeInMilliseconds BIGINT = NULL,
    @ToExecutionTimeInMilliseconds BIGINT = NULL,
    @RowsToSkip NVARCHAR(19) = '',
    @RowsToReturn NVARCHAR(19) = '',
    @RowOrder NVARCHAR(4) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'StoredProcedureLog';

    -- Set final values.
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        Id,
        EndUserId,
        EndUserIpAddress,
        StartedAt,
        EndedAt,
        ExecutionTimeInMilliseconds,
        HasExecutedSuccessfully,
        Name,
        Arguments
    FROM
        [dbo].[StoredProcedureLog]
    WHERE
        Id = COALESCE(@Id, Id)
        AND [dbo].[udf_IsEqualToUniqueIdentifierColumn](@EndUserId, EndUserId) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@EndUserIpAddress, EndUserIpAddress) = 1
        AND HasExecutedSuccessfully = COALESCE(@HasExecutedSuccessfully, HasExecutedSuccessfully)
        AND (Name = COALESCE(@Name, Name) OR Name LIKE @Name)
        AND (Arguments = COALESCE(@Arguments, Arguments) OR Arguments LIKE @Arguments)
        AND COALESCE(@FromStartedAt, StartedAt) <= StartedAt
        AND StartedAt <= COALESCE(@ToStartedAt, StartedAt)
        AND COALESCE(@FromEndedAt, EndedAt) <= EndedAt
        AND EndedAt <= COALESCE(@ToEndedAt, EndedAt)
        AND COALESCE(@FromExecutionTimeInMilliseconds, ExecutionTimeInMilliseconds) <= ExecutionTimeInMilliseconds
        AND ExecutionTimeInMilliseconds <= COALESCE(@ToExecutionTimeInMilliseconds, ExecutionTimeInMilliseconds)
    ORDER BY
        CASE WHEN (@RowOrder = 'DESC') THEN RowNumber END DESC,
        CASE WHEN (@RowOrder = 'ASC') THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInBigint](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInBigiint](@RowsToReturn) ROWS ONLY;
END;
