CREATE PROCEDURE [dbo].[usp_ReadBuilding]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(850) = '',
    @Name NVARCHAR(850) = '',
    -- DATETIME2(3) range parameters.
    @FromCreatedAt NVARCHAR(24) = '',
    @ToCreatedAt NVARCHAR(24) = '',
    -- Sort parameters.
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = '',
    -- Pagination parameters.
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
        -- Non-nullable foreign keys.
        '@CompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@CompanyId), ''', ',
        -- Non-nullable columns.
        '@Address = ''', [dbo].[udf_ConvertNullToNvarchar](@Address), ''', ',
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''', ',
        -- DATETIME2(3) range parameters.
        '@FromCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@FromCreatedAt), ''', ',
        '@ToCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@ToCreatedAt), ''', ',
        -- Sort parameters.
        '@SortColumn = ''', [dbo].[udf_ConvertNullToNvarchar](@SortColumn), ''', ',
        '@RowOrder = ''', [dbo].[udf_ConvertNullToNvarchar](@RowOrder), ''', ',
        -- Pagination parameters.
        '@RowsToSkip = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToSkip), ''', ',
        '@RowsToReturn = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToReturn), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Read';
    DECLARE @TableName NVARCHAR(4000) = 'Building';

    DECLARE @EndUserId UNIQUEIDENTIFIER;
    DECLARE @EndedAt DATETIME2(3);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorNumber INT;

    BEGIN TRY
        -- Set final values.
        SET @EndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

        -- Check the permission of the calling EndUser.
        EXEC [dbo].[usp_HasPermission] @EndUserId, @Operation, @TableName;

        -- Set final values.
        SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
        SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

        -- Run actual query.
        SELECT
        -- Non-nullable columns with default values.
            CreatedAt,
            Id,
            -- Non-nullable foreign keys.
            CompanyId,
            -- Non-nullable columns.
            Address,
            Name
        FROM
            [dbo].[Building]
        WHERE
        -- Non-nullable columns with default values.
            [dbo].[udf_IsEqualToUniqueIdentifier](@Id, Id) = 1
            -- Non-nullable foreign keys.
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@CompanyId, CompanyId) = 1
            -- Non-nullable columns.
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@Address, Address) = 1
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@Name, Name) = 1
            -- DATETIME2(3) range parameters.
            AND [dbo].[udf_IsBetweenDatetime2s](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
        ORDER BY
        -- Descending sort.
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Address')) THEN Address END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Name')) THEN Name END DESC,
            -- Ascending sort.
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Address')) THEN Address END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Name')) THEN Name END ASC
            -- Pagination.
            OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
            FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateStoredProcedureLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @CallingEndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
