CREATE PROCEDURE [dbo].[usp_CreateLog]
    @CallingEndUserID UNIQUEIDENTIFIER = NULL,
    @LogEndUserIP NVARCHAR(4000) = NULL,
    @LogStoredProcedureStart DATETIME,
    @LogStoredProcedureEnd DATETIME,
    @LogStoredProcedureSuccess BIT,
    @LogStoredProcedureName NVARCHAR(4000),
    @LogStoredProcedureParameters NVARCHAR(MAX)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Run actual query.
    INSERT INTO [dbo].[Log] (EndUserID, LogEndUserIP, LogStoredProcedureStart, LogStoredProcedureEnd, LogStoredProcedureSuccess, LogStoredProcedureName, LogStoredProcedureParameters)
    OUTPUT INSERTED.LogID, INSERTED.EndUserID, INSERTED.LogEndUserIP, INSERTED.LogStoredProcedureStart, INSERTED.LogStoredProcedureEnd, INSERTED.LogStoredProcedureMilliseconds, INSERTED.LogStoredProcedureSuccess, INSERTED.LogStoredProcedureName, INSERTED.LogStoredProcedureParameters
    VALUES (
        @CallingEndUserID,
        @LogEndUserIP,
        @LogStoredProcedureStart,
        @LogStoredProcedureEnd,
        @LogStoredProcedureSuccess,
        @LogStoredProcedureName,
        @LogStoredProcedureParameters
    );
END;
