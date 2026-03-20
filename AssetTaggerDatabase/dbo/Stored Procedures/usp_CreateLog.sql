CREATE PROCEDURE [dbo].[usp_CreateLog]
    @CallingEndUserID UNIQUEIDENTIFIER = NULL,
    @LogEndUserIP NVARCHAR(4000) = NULL,
    @LogStoredProcedureStart DATETIMEOFFSET(3),
    @LogStoredProcedureEnd DATETIMEOFFSET(3),
    @LogStoredProcedureSuccess BIT,
    @LogStoredProcedureName NVARCHAR(4000),
    @LogStoredProcedureParameters NVARCHAR(MAX)
AS;
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Run actual query.
        INSERT INTO [dbo].[Log] (
            EndUserID,
            LogEndUserIP,
            LogStoredProcedureStart,
            LogStoredProcedureEnd,
            LogStoredProcedureSuccess,
            LogStoredProcedureName,
            LogStoredProcedureParameters
        )
        OUTPUT
            INSERTED.LogID,
            INSERTED.EndUserID,
            INSERTED.LogEndUserIP,
            INSERTED.LogStoredProcedureStart,
            INSERTED.LogStoredProcedureEnd,
            INSERTED.LogStoredProcedureMilliseconds,
            INSERTED.LogStoredProcedureSuccess,
            INSERTED.LogStoredProcedureName,
            INSERTED.LogStoredProcedureParameters
        VALUES (
            @CallingEndUserID,
            @LogEndUserIP,
            @LogStoredProcedureStart,
            @LogStoredProcedureEnd,
            @LogStoredProcedureSuccess,
            @LogStoredProcedureName,
            @LogStoredProcedureParameters
        );
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();

        -- Only run query below this IF statement if @ErrorNumber is equal to 547 and @ErrorMessage is equal to the error message in the IF statement.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/relational-databases/errors-events/database-engine-events-and-errors-0-to-999
        IF (
            @ErrorNumber != 547
            AND @ErrorMessage != 'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Log_EndUser". The conflict occurred in database "AssetTaggerDatabase", table "dbo.EndUser", column ''EndUserID''.'
        )
            BEGIN
                DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
                DECLARE @ErrorState INT = ERROR_STATE();
                RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
                RETURN -1;
            END;

        -- Run same query again but @CallingEndUserID is replaced with NULL to fix error specified in IF statement above.
        INSERT INTO [dbo].[Log] (
            EndUserID,
            LogEndUserIP,
            LogStoredProcedureStart,
            LogStoredProcedureEnd,
            LogStoredProcedureSuccess,
            LogStoredProcedureName,
            LogStoredProcedureParameters
        )
        OUTPUT
            INSERTED.LogID,
            INSERTED.EndUserID,
            INSERTED.LogEndUserIP,
            INSERTED.LogStoredProcedureStart,
            INSERTED.LogStoredProcedureEnd,
            INSERTED.LogStoredProcedureMilliseconds,
            INSERTED.LogStoredProcedureSuccess,
            INSERTED.LogStoredProcedureName,
            INSERTED.LogStoredProcedureParameters
        VALUES (
            NULL,
            @LogEndUserIP,
            @LogStoredProcedureStart,
            @LogStoredProcedureEnd,
            @LogStoredProcedureSuccess,
            @LogStoredProcedureName,
            @LogStoredProcedureParameters
        );
    END CATCH;
END;
