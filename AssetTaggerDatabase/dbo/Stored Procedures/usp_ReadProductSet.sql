CREATE PROCEDURE [dbo].[usp_ReadProductSet]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ParentProductID UNIQUEIDENTIFIER = NULL,
    @ProductID UNIQUEIDENTIFIER = NULL,
    @FromProductSetProductQuantity INT = NULL,
    @ToProductSetProductQuantity INT = NULL,
    @FromProductSetInsertDate DATETIME = NULL,
    @ToProductSetInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadProductSet BIT = (SELECT ReadProductSet FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadProductSet IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadProductSet = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        ParentProductID,
        ProductID,
        ProductSetProductQuantity,
        ProductSetInsertDate
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductID = ISNULL(@ParentProductID, ParentProductID)
        AND ProductID = ISNULL(@ProductID, ProductID)
        AND ISNULL(@FromProductSetProductQuantity, ProductSetProductQuantity) <= ProductSetProductQuantity
        AND ProductSetProductQuantity <= ISNULL(@ToProductSetProductQuantity, ProductSetProductQuantity)
        AND ISNULL(@FromProductSetInsertDate, ProductSetInsertDate) <= ProductSetInsertDate
        AND ProductSetInsertDate <= ISNULL(@ToProductSetInsertDate, ProductSetInsertDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN ProductSetNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN ProductSetNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
