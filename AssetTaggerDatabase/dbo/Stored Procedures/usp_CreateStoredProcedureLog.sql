CREATE PROCEDURE [dbo].[usp_CreateStoredProcedureLog]
    @CallingEndUserId NVARCHAR(36) = NULL,
    @EndUserIpAddress NVARCHAR(4000) = NULL,
    @StartedAt DATETIME2(3),
    @EndedAt DATETIME2(3),
    @HasExecutedSuccessfully BIT,
    @Name NVARCHAR(4000),
    @Arguments NVARCHAR(MAX)
AS;
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Run actual query.
        INSERT INTO [dbo].[StoredProcedureLog] (
            EndUserId,
            EndUserIpAddress,
            StartedAt,
            EndedAt,
            HasExecutedSuccessfully,
            Name,
            Arguments
        )
        OUTPUT
            INSERTED.Id,
            INSERTED.EndUserId,
            INSERTED.EndUserIpAddress,
            INSERTED.StartedAt,
            INSERTED.EndedAt,
            INSERTED.ExecutionTimeInMilliseconds,
            INSERTED.HasExecutedSuccessfully,
            INSERTED.Name,
            INSERTED.Arguments
        VALUES (
            @CallingEndUserId,
            @EndUserIpAddress,
            @StartedAt,
            @EndedAt,
            @HasExecutedSuccessfully,
            @Name,
            @Arguments
        );
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();

        -- Only run query below this IF statement if @ErrorNumber is equal to 547 and @ErrorMessage is equal to the error message in the IF statement.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/relational-databases/errors-events/database-engine-events-and-errors-0-to-999
        IF (
            @ErrorNumber <> 547
            AND @ErrorMessage <> 'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Log_EndUser". The conflict occurred in database "AssetTaggerDatabase", table "dbo.EndUser", column ''EndUserId''.'
        )
            BEGIN
                DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
                DECLARE @ErrorState INT = ERROR_STATE();
                RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
                RETURN -1;
            END;

        -- Run same query again but @CallingEndUserId is replaced with NULL to fix error specified in IF statement above.
        INSERT INTO [dbo].[StoredProcedureLog] (
            EndUserId,
            EndUserIpAddress,
            StartedAt,
            EndedAt,
            HasExecutedSuccessfully,
            Name,
            Arguments
        )
        OUTPUT
            INSERTED.Id,
            INSERTED.EndUserId,
            INSERTED.EndUserIpAddress,
            INSERTED.StartedAt,
            INSERTED.EndedAt,
            INSERTED.ExecutionTimeInMilliseconds,
            INSERTED.HasExecutedSuccessfully,
            INSERTED.Name,
            INSERTED.Arguments
        VALUES (
            NULL,
            @EndUserIpAddress,
            @StartedAt,
            @EndedAt,
            @HasExecutedSuccessfully,
            @Name,
            @Arguments
        );
    END CATCH;
END;
