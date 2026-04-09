CREATE PROCEDURE [dbo].[usp_ReadLog]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @EndUserId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @EndUserIpAddress NVARCHAR(4000) = '',
    @HasExecutedSuccessfully BIT = NULL,
    @Name NVARCHAR(4000) = NULL,
    @Arguments NVARCHAR(MAX) = NULL,
    @FromStartedAt DATETIMEOFFSET(3) = NULL,
    @ToStartedAt DATETIMEOFFSET(3) = NULL,
    @FromEndedAt DATETIMEOFFSET(3) = NULL,
    @ToEndedAt DATETIMEOFFSET(3) = NULL,
    @FromExecutionTimeInMilliseconds BIGINT = NULL,
    @ToExecutionTimeInMilliseconds BIGINT = NULL,
    @RowsToSkip BIGINT = NULL,
    @RowsToReturn BIGINT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingStoredProcedureLogPermission BIT = (SELECT HasReadingStoredProcedureLogPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingStoredProcedureLogPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingStoredProcedureLogPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Log!', 11, 0);
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
        Id = ISNULL(@Id, Id)
        AND EndUserId IS NOT DISTINCT FROM IIF(@EndUserId = @NULLISH_UNIQUEIDENTIFIER, EndUserId, IIF(@EndUserId = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(EndUserId, @NON_NULLISH_UNIQUEIDENTIFIER), @EndUserId))
        AND (EndUserIpAddress IS NOT DISTINCT FROM IIF(@EndUserIpAddress = @NULLISH_NVARCHAR, EndUserIpAddress, IIF(@EndUserIpAddress = @NON_NULLISH_NVARCHAR, ISNULL(EndUserIpAddress, @NON_NULLISH_NVARCHAR), @EndUserIpAddress)) OR EndUserIpAddress LIKE @EndUserIpAddress)
        AND HasExecutedSuccessfully = ISNULL(@HasExecutedSuccessfully, HasExecutedSuccessfully)
        AND (Name = ISNULL(@Name, Name) OR Name LIKE @Name)
        AND (Arguments = ISNULL(@Arguments, Arguments) OR Arguments LIKE @Arguments)
        AND ISNULL(@FromStartedAt, StartedAt) <= StartedAt
        AND StartedAt <= ISNULL(@ToStartedAt, StartedAt)
        AND ISNULL(@FromEndedAt, EndedAt) <= EndedAt
        AND EndedAt <= ISNULL(@ToEndedAt, EndedAt)
        AND ISNULL(@FromExecutionTimeInMilliseconds, ExecutionTimeInMilliseconds) <= ExecutionTimeInMilliseconds
        AND ExecutionTimeInMilliseconds <= ISNULL(@ToExecutionTimeInMilliseconds, ExecutionTimeInMilliseconds)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 9,223,372,036,854,775,807 rows which is the upper limit of BIGINT, the data type of RowNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 9223372036854775807) ROWS ONLY;
END;
