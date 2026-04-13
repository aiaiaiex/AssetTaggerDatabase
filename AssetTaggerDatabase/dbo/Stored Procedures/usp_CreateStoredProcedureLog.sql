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
    VALUES (
        @CallingEndUserId,
        @EndUserIpAddress,
        @StartedAt,
        @EndedAt,
        @HasExecutedSuccessfully,
        @Name,
        @Arguments
    );
END;
