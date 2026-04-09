CREATE PROCEDURE [dbo].[usp_ReadLocation]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Address NVARCHAR(842) = NULL,
    @BuildingId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIMEOFFSET(3) = NULL,
    @ToCreatedAt DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingLocationPermission BIT = (SELECT HasReadingLocationPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingLocationPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingLocationPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        Address,
        BuildingId,
        CreatedAt
    FROM
        [dbo].[Location]
    WHERE
        Id = ISNULL(@Id, Id)
        AND (Address = ISNULL(@Address, Address) OR Address LIKE @Address)
        AND BuildingId = ISNULL(@BuildingId, BuildingId)
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
