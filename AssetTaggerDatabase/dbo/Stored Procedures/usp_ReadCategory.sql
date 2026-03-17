CREATE PROCEDURE [dbo].[usp_ReadCategory]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CategoryID UNIQUEIDENTIFIER = NULL,
    @CategoryName NVARCHAR(850) = NULL,
    @FromCategoryInsertDate DATETIME = NULL,
    @ToCategoryInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = 1
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadCategory BIT = (SELECT ReadCategory FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadCategory IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadCategory = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Category!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        CategoryID,
        CategoryName,
        CategoryInsertDate
    FROM
        [dbo].[Category]
    WHERE
        CategoryID = ISNULL(@CategoryID, CategoryID)
        AND (CategoryName = ISNULL(@CategoryName, CategoryName) OR CategoryName LIKE @CategoryName)
        AND ISNULL(@FromCategoryInsertDate, CategoryInsertDate) <= CategoryInsertDate
        AND CategoryInsertDate <= ISNULL(@ToCategoryInsertDate, CategoryInsertDate)
    ORDER BY
        CASE WHEN @NewestRowsFirst = 1 THEN CategoryNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN CategoryNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
