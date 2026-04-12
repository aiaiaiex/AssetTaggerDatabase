CREATE PROCEDURE [dbo].[usp_ReadCompany]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @Code NVARCHAR(5) = NULL,
    @ParentCompanyId NVARCHAR(36) = '',
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @RowOrder NVARCHAR(4) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Company';

    -- Set final values.
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        Id,
        Name,
        Address,
        Code,
        ParentCompanyId,
        CreatedAt
    FROM
        [dbo].[Company]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (Name = COALESCE(@Name, Name) OR Name LIKE @Name)
        AND (Address = COALESCE(@Address, Address) OR Address LIKE @Address)
        AND (Code = COALESCE(@Code, Code) OR Code LIKE @Code)
        AND [dbo].[udf_IsEqualToUniqueIdentifierColumn](@ParentCompanyId, ParentCompanyId) = 1
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN (@RowOrder = 'DESC') THEN RowNumber END DESC,
        CASE WHEN (@RowOrder = 'ASC') THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
