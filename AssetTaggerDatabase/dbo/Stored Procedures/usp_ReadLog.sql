CREATE PROCEDURE [dbo].[usp_ReadLog]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LogID UNIQUEIDENTIFIER = NULL,
    @EndUserID UNIQUEIDENTIFIER = NULL,
    @LogEndUserIP NVARCHAR(4000) = '',
    @LogStoredProcedureSuccess BIT = NULL,
    @LogStoredProcedureName NVARCHAR(4000) = NULL,
    @LogStoredProcedureParameters NVARCHAR(MAX) = NULL,
    @FromLogStoredProcedureStart DATETIME = NULL,
    @ToLogStoredProcedureStart DATETIME = NULL,
    @FromLogStoredProcedureEnd DATETIME = NULL,
    @ToLogStoredProcedureEnd DATETIME = NULL,
    @FromLogStoredProcedureMilliseconds INT = NULL,
    @ToLogStoredProcedureMilliseconds INT = NULL,
    @RowsToSkip BIGINT = NULL,
    @RowsToReturn BIGINT = NULL,
    @NewestRowsFirst BIT = NULL -- Defaults to 1 when NULL.
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadLog BIT = (SELECT ReadLog FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadLog IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadLog = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Log!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);

    -- Run actual query.
    SELECT
        LogID,
        EndUserID,
        LogEndUserIP,
        LogStoredProcedureStart,
        LogStoredProcedureEnd,
        LogStoredProcedureMilliseconds,
        LogStoredProcedureSuccess,
        LogStoredProcedureName,
        LogStoredProcedureParameters
    FROM [dbo].[Log]
    WHERE LogID = ISNULL(@LogID, LogID) AND EndUserID = ISNULL(@EndUserID, EndUserID) AND (LogEndUserIP IS NOT DISTINCT FROM IIF(@LogEndUserIP = @NULLISH_NVARCHAR, LogEndUserIP, IIF(@LogEndUserIP = @NON_NULLISH_NVARCHAR, ISNULL(LogEndUserIP, @NON_NULLISH_NVARCHAR), @LogEndUserIP)) OR LogEndUserIP LIKE @LogEndUserIP) AND LogStoredProcedureSuccess = ISNULL(@LogStoredProcedureSuccess, LogStoredProcedureSuccess) AND (LogStoredProcedureName = ISNULL(@LogStoredProcedureName, LogStoredProcedureName) OR LogStoredProcedureName LIKE @LogStoredProcedureName) AND (LogStoredProcedureParameters = ISNULL(@LogStoredProcedureParameters, LogStoredProcedureParameters) OR LogStoredProcedureParameters LIKE @LogStoredProcedureParameters) AND ISNULL(@FromLogStoredProcedureStart, LogStoredProcedureStart) <= LogStoredProcedureStart AND LogStoredProcedureStart <= ISNULL(@ToLogStoredProcedureStart, LogStoredProcedureStart) AND ISNULL(@FromLogStoredProcedureEnd, LogStoredProcedureEnd) <= LogStoredProcedureEnd AND LogStoredProcedureEnd <= ISNULL(@ToLogStoredProcedureEnd, LogStoredProcedureEnd) AND ISNULL(@FromLogStoredProcedureMilliseconds, LogStoredProcedureMilliseconds) <= LogStoredProcedureMilliseconds AND LogStoredProcedureMilliseconds <= ISNULL(@ToLogStoredProcedureMilliseconds, LogStoredProcedureMilliseconds)
    ORDER BY
        CASE WHEN @NewestRowsFirst IS NULL OR @NewestRowsFirst = 1 THEN LogNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN LogNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 9,223,372,036,854,775,807 rows which is the upper limit of BIGINT, the data type of LogNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 9223372036854775807) ROWS ONLY;
END;
