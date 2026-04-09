CREATE PROCEDURE [dbo].[usp_ReadStoredProcedureLog]
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
        Id = COALESCE(@Id, Id)
        AND EndUserId IS NOT DISTINCT FROM IIF(@EndUserId = @NULLISH_UNIQUEIDENTIFIER, EndUserId, IIF(@EndUserId = @NON_NULLISH_UNIQUEIDENTIFIER, COALESCE(EndUserId, @NON_NULLISH_UNIQUEIDENTIFIER), @EndUserId))
        AND (EndUserIpAddress IS NOT DISTINCT FROM IIF(@EndUserIpAddress = @NULLISH_NVARCHAR, EndUserIpAddress, IIF(@EndUserIpAddress = @NON_NULLISH_NVARCHAR, COALESCE(EndUserIpAddress, @NON_NULLISH_NVARCHAR), @EndUserIpAddress)) OR EndUserIpAddress LIKE @EndUserIpAddress)
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
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET COALESCE(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 9,223,372,036,854,775,807 rows which is the upper limit of BIGINT, the data type of RowNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT COALESCE(@RowsToReturn, CAST(9223372036854775807 AS BIGINT)) ROWS ONLY;
END;
