CREATE PROCEDURE [dbo].[usp_ReadCompany]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @Code NVARCHAR(5) = NULL,
    @ParentCompanyId NVARCHAR(36) = '',
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingCompanyPermission BIT = (SELECT HasReadingCompanyPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingCompanyPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingCompanyPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Company!', 11, 0);
            RETURN -1;
        END;

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
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
