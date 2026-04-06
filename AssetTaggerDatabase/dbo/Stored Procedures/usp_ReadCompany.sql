CREATE PROCEDURE [dbo].[usp_ReadCompany]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL,
    @Code NVARCHAR(5) = NULL,
    @ParentCompanyId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @FromCreatedAt DATETIMEOFFSET(3) = NULL,
    @ToCreatedAt DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingCompanyPermission BIT = (SELECT HasReadingCompanyPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasReadingCompanyPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingCompanyPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Company!', 11, 0);
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
        Id = ISNULL(@Id, Id)
        AND (Name = ISNULL(@Name, Name) OR Name LIKE @Name)
        AND (Address = ISNULL(@Address, Address) OR Address LIKE @Address)
        AND (Code = ISNULL(@Code, Code) OR Code LIKE @Code)
        AND ParentCompanyId IS NOT DISTINCT FROM IIF(@ParentCompanyId = @NULLISH_UNIQUEIDENTIFIER, ParentCompanyId, IIF(@ParentCompanyId = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(ParentCompanyId, @NON_NULLISH_UNIQUEIDENTIFIER), @ParentCompanyId))
        AND ISNULL(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= ISNULL(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
