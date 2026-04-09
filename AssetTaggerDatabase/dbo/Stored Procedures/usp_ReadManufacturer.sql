CREATE PROCEDURE [dbo].[usp_ReadManufacturer]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(850) = NULL,
    @FromCreatedAt DATETIMEOFFSET(3) = NULL,
    @ToCreatedAt DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingManufacturerPermission BIT = (SELECT HasReadingManufacturerPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingManufacturerPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingManufacturerPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Manufacturer!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        Name,
        CreatedAt
    FROM
        [dbo].[Manufacturer]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (Name = COALESCE(@Name, Name) OR Name LIKE @Name)
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
