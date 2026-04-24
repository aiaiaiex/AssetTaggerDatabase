CREATE PROCEDURE [dbo].[usp_CreateStoredProcedureLog]
    -- Nullable foreign keys.
    @EndUserId UNIQUEIDENTIFIER = NULL,
    -- Non-nullable columns.
    @Arguments NVARCHAR(MAX),
    @EndedAt DATETIME2(3),
    @HasExecutedSuccessfully BIT,
    @Operation NVARCHAR(6),
    @StartedAt DATETIME2(3),
    @TableName NVARCHAR(4000),
    -- Nullable columns.
    @EndUserIpAddress NVARCHAR(4000) = NULL,
    @ErrorMessage NVARCHAR(4000) = NULL,
    @ErrorNumber INT = NULL
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
        Operation,
        StartedAt,
        TableName,
        -- Nullable columns.
        EndUserIpAddress,
        ErrorMessage,
        ErrorNumber
    )
    VALUES (
        -- Nullable foreign keys.
        @EndUserId,
        -- Non-nullable columns.
        @Arguments,
        @EndedAt,
        @HasExecutedSuccessfully,
        @Operation,
        @StartedAt,
        @TableName,
        -- Nullable columns.
        @EndUserIpAddress,
        @ErrorMessage,
        @ErrorNumber
    );
END;
