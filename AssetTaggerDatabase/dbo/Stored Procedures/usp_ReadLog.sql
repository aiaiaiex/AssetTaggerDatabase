CREATE PROCEDURE [dbo].[usp_ReadLog]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LogID UNIQUEIDENTIFIER = NULL,
    @EndUserID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @LogEndUserIP NVARCHAR(4000) = '',
    @LogStoredProcedureSuccess BIT = NULL,
    @LogStoredProcedureName NVARCHAR(4000) = NULL,
    @LogStoredProcedureParameters NVARCHAR(MAX) = NULL,
    @FromLogStoredProcedureStart DATETIMEOFFSET(3) = NULL,
    @ToLogStoredProcedureStart DATETIMEOFFSET(3) = NULL,
    @FromLogStoredProcedureEnd DATETIMEOFFSET(3) = NULL,
    @ToLogStoredProcedureEnd DATETIMEOFFSET(3) = NULL,
    @FromLogStoredProcedureMilliseconds BIGINT = NULL,
    @ToLogStoredProcedureMilliseconds BIGINT = NULL,
    @RowsToSkip BIGINT = NULL,
    @RowsToReturn BIGINT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingLogPermission BIT = (SELECT HasReadingLogPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasReadingLogPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingLogPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Log!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);
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
    FROM
        [dbo].[Log]
    WHERE
        LogID = ISNULL(@LogID, LogID)
        AND EndUserID IS NOT DISTINCT FROM IIF(@EndUserID = @NULLISH_UNIQUEIDENTIFIER, EndUserID, IIF(@EndUserID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(EndUserID, @NON_NULLISH_UNIQUEIDENTIFIER), @EndUserID))
        AND (LogEndUserIP IS NOT DISTINCT FROM IIF(@LogEndUserIP = @NULLISH_NVARCHAR, LogEndUserIP, IIF(@LogEndUserIP = @NON_NULLISH_NVARCHAR, ISNULL(LogEndUserIP, @NON_NULLISH_NVARCHAR), @LogEndUserIP)) OR LogEndUserIP LIKE @LogEndUserIP)
        AND LogStoredProcedureSuccess = ISNULL(@LogStoredProcedureSuccess, LogStoredProcedureSuccess)
        AND (LogStoredProcedureName = ISNULL(@LogStoredProcedureName, LogStoredProcedureName) OR LogStoredProcedureName LIKE @LogStoredProcedureName)
        AND (LogStoredProcedureParameters = ISNULL(@LogStoredProcedureParameters, LogStoredProcedureParameters) OR LogStoredProcedureParameters LIKE @LogStoredProcedureParameters)
        AND ISNULL(@FromLogStoredProcedureStart, LogStoredProcedureStart) <= LogStoredProcedureStart
        AND LogStoredProcedureStart <= ISNULL(@ToLogStoredProcedureStart, LogStoredProcedureStart)
        AND ISNULL(@FromLogStoredProcedureEnd, LogStoredProcedureEnd) <= LogStoredProcedureEnd
        AND LogStoredProcedureEnd <= ISNULL(@ToLogStoredProcedureEnd, LogStoredProcedureEnd)
        AND ISNULL(@FromLogStoredProcedureMilliseconds, LogStoredProcedureMilliseconds) <= LogStoredProcedureMilliseconds
        AND LogStoredProcedureMilliseconds <= ISNULL(@ToLogStoredProcedureMilliseconds, LogStoredProcedureMilliseconds)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN LogNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN LogNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 9,223,372,036,854,775,807 rows which is the upper limit of BIGINT, the data type of LogNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 9223372036854775807) ROWS ONLY;
END;
