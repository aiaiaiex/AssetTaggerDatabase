CREATE PROCEDURE [dbo].[usp_CreateLog]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LogEndUserIP NVARCHAR(4000) = NULL,
    @LogStoredProcedureStart DATETIME,
    @LogStoredProcedureEnd DATETIME,
    @LogStoredProcedureSuccess BIT,
    @LogStoredProcedureName NVARCHAR(4000),
    @LogStoredProcedureParameters NVARCHAR(MAX)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateLog BIT = (SELECT CreateLog FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateLog IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateLog = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Log!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Log] (EndUserID, LogEndUserIP, LogStoredProcedureStart, LogStoredProcedureEnd, LogStoredProcedureSuccess, LogStoredProcedureName, LogStoredProcedureParameters)
    OUTPUT INSERTED.LogID, INSERTED.EndUserID, INSERTED.LogEndUserIP, INSERTED.LogStoredProcedureStart, INSERTED.LogStoredProcedureEnd, INSERTED.LogStoredProcedureSuccess, INSERTED.LogStoredProcedureName, INSERTED.LogStoredProcedureParameters
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
