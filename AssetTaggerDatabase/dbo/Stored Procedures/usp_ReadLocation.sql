CREATE PROCEDURE [dbo].[usp_ReadLocation]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LocationID UNIQUEIDENTIFIER = NULL,
    @LocationAddress NVARCHAR(842) = NULL,
    @BuildingID UNIQUEIDENTIFIER = NULL,
    @FromLocationInsertDate DATETIME = NULL,
    @ToLocationInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadLocation BIT = (SELECT ReadLocation FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadLocation IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadLocation = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Location!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        LocationID,
        LocationAddress,
        BuildingID,
        LocationInsertDate
    FROM
        [dbo].[Location]
    WHERE
        LocationID = ISNULL(@LocationID, LocationID)
        AND (LocationAddress = ISNULL(@LocationAddress, LocationAddress) OR LocationAddress LIKE @LocationAddress)
        AND BuildingID = ISNULL(@BuildingID, BuildingID)
        AND ISNULL(@FromLocationInsertDate, LocationInsertDate) <= LocationInsertDate
        AND LocationInsertDate <= ISNULL(@ToLocationInsertDate, LocationInsertDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN LocationNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN LocationNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
