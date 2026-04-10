CREATE PROCEDURE [dbo].[usp_ReadCompany]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @Code NVARCHAR(5) = NULL,
    @ParentCompanyId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingCompanyPermission BIT = (SELECT HasReadingCompanyPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

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

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);

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
        AND ParentCompanyId IS NOT DISTINCT FROM IIF(@ParentCompanyId = @NULLISH_UNIQUEIDENTIFIER, ParentCompanyId, IIF(@ParentCompanyId = @NON_NULLISH_UNIQUEIDENTIFIER, COALESCE(ParentCompanyId, @NON_NULLISH_UNIQUEIDENTIFIER), @ParentCompanyId))
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET COALESCE(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT COALESCE(@RowsToReturn, 2147483647) ROWS ONLY;
END;
