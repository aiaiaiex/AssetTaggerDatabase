CREATE PROCEDURE [dbo].[usp_ReadPermission]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @RoleId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Operation NVARCHAR(6) = '',
    @TableName NVARCHAR(836) = '',
    -- DATETIME2(3) range parameters.
    @FromCreatedAt NVARCHAR(24) = '',
    @ToCreatedAt NVARCHAR(24) = '',
    -- Sort parameters.
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = '',
    -- Pagination parameters.
    @RowsToSkip NVARCHAR(19) = '',
    @RowsToReturn NVARCHAR(19) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
        -- Non-nullable foreign keys.
        '@RoleId = ''', [dbo].[udf_ConvertNullToNvarchar](@RoleId), ''', ',
        -- Non-nullable columns.
        '@Operation = ''', [dbo].[udf_ConvertNullToNvarchar](@Operation), ''', ',
        '@TableName = ''', [dbo].[udf_ConvertNullToNvarchar](@TableName), ''', ',
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
    DECLARE @LogOperation NVARCHAR(6) = 'Read';
    DECLARE @LogTableName NVARCHAR(836) = 'Permission';
    DECLARE @EndUserIpAddress NVARCHAR(4000) = [dbo].[udf_GetDefaultNvarchar](@CallingEndUserIpAddress, NULL);

    DECLARE @EndUserId UNIQUEIDENTIFIER;
    DECLARE @EndedAt DATETIME2(3);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorNumber INT;

    BEGIN TRY
        -- Set final values.
        SET @EndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

        -- Check the permission of the calling EndUser.
        EXEC [dbo].[usp_HasPermission] @EndUserId, @LogOperation, @LogTableName;

        -- Set final values.
        SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
        SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

        -- Run actual query.
        SELECT
            -- Non-nullable columns with default values.
            CreatedAt,
            Id,
            -- Non-nullable foreign keys.
            RoleId,
            -- Non-nullable columns.
            Operation,
            TableName
        FROM
            [dbo].[Permission]
        WHERE
            -- Non-nullable columns with default values.
            [dbo].[udf_IsEqualToUniqueIdentifier](@Id, Id) = 1
            -- Non-nullable foreign keys.
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@RoleId, RoleId) = 1
            -- Non-nullable columns.
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@Operation, Operation) = 1
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@TableName, TableName) = 1
            -- DATETIME2(3) range parameters.
            AND [dbo].[udf_IsBetweenDatetime2s](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
        ORDER BY
            -- Descending sort.
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Operation')) THEN Operation END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'TableName')) THEN TableName END DESC,
            -- Ascending sort.
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Operation')) THEN Operation END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'TableName')) THEN TableName END ASC
            -- Pagination.
            OFFSET [dbo].[udf_GetRowsToSkip](@RowsToSkip) ROWS
            FETCH NEXT [dbo].[udf_GetRowsToReturn](@RowsToReturn) ROWS ONLY;
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @LogOperation, @StartedAt, @LogTableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
