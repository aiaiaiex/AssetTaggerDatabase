CREATE PROCEDURE [dbo].[usp_CreateStoredProcedureLog]
    -- Nullable foreign keys.
    @CallingEndUserId UNIQUEIDENTIFIER = NULL,
    -- Non-nullable columns.
    @Arguments NVARCHAR(MAX),
    @EndedAt DATETIME2(3),
    @HasExecutedSuccessfully BIT,
    @Name NVARCHAR(4000),
    @StartedAt DATETIME2(3),
    -- Nullable columns.
    @EndUserIpAddress NVARCHAR(4000) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Run actual query.
    INSERT INTO [dbo].[StoredProcedureLog] (
        -- Nullable foreign keys.
        EndUserId,
        -- Non-nullable columns.
        Arguments,
        EndedAt,
        HasExecutedSuccessfully,
        Name,
        StartedAt,
        -- Nullable columns.
        EndUserIpAddress
    )
    VALUES (
        -- Nullable foreign keys.
        @CallingEndUserId,
        -- Non-nullable columns.
        @Arguments,
        @EndedAt,
        @HasExecutedSuccessfully,
        @Name,
        @StartedAt,
        -- Nullable columns.
        @EndUserIpAddress
    );
END;
