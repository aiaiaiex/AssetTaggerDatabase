CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER = NULL,
    @Username NVARCHAR(850) = NULL,
    @EndUserRoleId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'EndUser';

    -- Set final values.
    SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        Id,
        Username,
        EndUserRoleId,
        EmployeeId,
        CreatedAt
    FROM
        [dbo].[EndUser]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (Username = COALESCE(@Username, Username) OR Username LIKE @Username)
        AND EndUserRoleId = COALESCE(@EndUserRoleId, EndUserRoleId)
        AND EmployeeId = COALESCE(@EmployeeId, EmployeeId)
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Username')) THEN Username END DESC,
        -- 
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Username')) THEN Username END ASC
        -- 
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
