CREATE PROCEDURE [dbo].[usp_ReadProduct]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @CategoryId NVARCHAR(36) = '',
    @ManufacturerId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @ModelNumber NVARCHAR(421) = '',
    @Name NVARCHAR(421) = '',
    -- DATETIME2(3) range parameters.
    @FromCreatedAt NVARCHAR(24) = '',
    @ToCreatedAt NVARCHAR(24) = '',
    -- Sort parameters.
    @SortColumn NVARCHAR(4000) = '',
    @SortOrder NVARCHAR(4) = '',
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
        -- Nullable foreign keys.
        '@CategoryId = ''', [dbo].[udf_ConvertNullToNvarchar](@CategoryId), ''', ',
        '@ManufacturerId = ''', [dbo].[udf_ConvertNullToNvarchar](@ManufacturerId), ''', ',
        -- Non-nullable columns.
        '@DocumentationUrl = ''', [dbo].[udf_ConvertNullToNvarchar](@DocumentationUrl), ''', ',
        '@ModelNumber = ''', [dbo].[udf_ConvertNullToNvarchar](@ModelNumber), ''', ',
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''', ',
        -- DATETIME2(3) range parameters.
        '@FromCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@FromCreatedAt), ''', ',
        '@ToCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@ToCreatedAt), ''', ',
        -- Sort parameters.
        '@SortColumn = ''', [dbo].[udf_ConvertNullToNvarchar](@SortColumn), ''', ',
        '@SortOrder = ''', [dbo].[udf_ConvertNullToNvarchar](@SortOrder), ''', ',
        -- Pagination parameters.
        '@RowsToSkip = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToSkip), ''', ',
        '@RowsToReturn = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToReturn), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Read';
    DECLARE @TableName NVARCHAR(836) = 'Product';
    DECLARE @EndUserIpAddress NVARCHAR(4000) = [dbo].[udf_GetDefaultNvarchar](@CallingEndUserIpAddress, NULL);

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
        SET @SortOrder = [dbo].[udf_GetSortOrder](@SortOrder);

        -- Run actual query.
        SELECT
        -- Non-nullable columns with default values.
            CreatedAt,
            Id,
            -- Nullable foreign keys.
            CategoryId,
            ManufacturerId,
            -- Nullable columns.
            DocumentationUrl,
            ModelNumber,
            Name
        FROM
            [dbo].[Product]
        WHERE
        -- Non-nullable columns with default values.
            [dbo].[udf_IsEqualToUniqueIdentifier](@Id, Id) = 1
            -- Nullable foreign keys.
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@CategoryId, CategoryId) = 1
            AND [dbo].[udf_IsEqualToUniqueIdentifier](@ManufacturerId, ManufacturerId) = 1
            -- Nullable columns.
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@DocumentationUrl, DocumentationUrl) = 1
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@ModelNumber, ModelNumber) = 1
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@Name, Name) = 1
            -- DATETIME2(3) range parameters.
            AND [dbo].[udf_IsBetweenDatetime2s](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
        ORDER BY
        -- Descending sort.
            CASE WHEN ((@SortOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
            CASE WHEN ((@SortOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
            CASE WHEN ((@SortOrder = 'DESC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END DESC,
            CASE WHEN ((@SortOrder = 'DESC') AND (@SortColumn = 'ModelNumber')) THEN ModelNumber END DESC,
            CASE WHEN ((@SortOrder = 'DESC') AND (@SortColumn = 'Name')) THEN Name END DESC,
            -- Ascending sort.
            CASE WHEN ((@SortOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
            CASE WHEN ((@SortOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
            CASE WHEN ((@SortOrder = 'ASC') AND (@SortColumn = 'DocumentationUrl')) THEN DocumentationUrl END ASC,
            CASE WHEN ((@SortOrder = 'ASC') AND (@SortColumn = 'ModelNumber')) THEN ModelNumber END ASC,
            CASE WHEN ((@SortOrder = 'ASC') AND (@SortColumn = 'Name')) THEN Name END ASC
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
    EXEC [dbo].[usp_CreateLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;

    -- Re-raise error.
    IF (@ErrorMessage IS NOT NULL)
        BEGIN
            RAISERROR (@ErrorMessage, 11, 0);
            RETURN -1;
        END;
END;
