CREATE PROCEDURE [dbo].[usp_ReadEmployee]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    @DepartmentId NVARCHAR(36) = '',
    @RoleId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @FullName NVARCHAR(850) = '',
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

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Employee';

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
        DepartmentId,
        RoleId,
        -- Non-nullable columns.
        FullName
    FROM
        [dbo].[Employee]
    WHERE
        -- Non-nullable columns with default values.
        [dbo].[udf_IsEqualToUniqueIdentifier](@Id, Id) = 1
        -- Non-nullable foreign keys.
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@CompanyId, CompanyId) = 1
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@DepartmentId, DepartmentId) = 1
        AND [dbo].[udf_IsEqualToUniqueIdentifier](@RoleId, RoleId) = 1
        -- Non-nullable columns.
        AND [dbo].[udf_IsEqualToOrLikeNvarchar](@FullName, FullName) = 1
        -- DATETIME2(3) range parameters.
        AND [dbo].[udf_IsBetweenDatetime2s](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
    ORDER BY
        -- Descending sort.
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'FullName')) THEN FullName END DESC,
        -- Ascending sort.
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'FullName')) THEN FullName END ASC
        -- Pagination.
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
