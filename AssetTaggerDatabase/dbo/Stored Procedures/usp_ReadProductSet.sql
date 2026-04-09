CREATE PROCEDURE [dbo].[usp_ReadProductSet]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @ParentProductId UNIQUEIDENTIFIER = NULL,
    @ProductId UNIQUEIDENTIFIER = NULL,
    @FromProductQuantity INT = NULL,
    @ToProductQuantity INT = NULL,
    @FromCreatedAt DATETIMEOFFSET(3) = NULL,
    @ToCreatedAt DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingProductSetPermission BIT = (SELECT HasReadingProductSetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingProductSetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingProductSetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        ParentProductId,
        ProductId,
        ProductQuantity,
        CreatedAt
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductId = COALESCE(@ParentProductId, ParentProductId)
        AND ProductId = COALESCE(@ProductId, ProductId)
        AND COALESCE(@FromProductQuantity, ProductQuantity) <= ProductQuantity
        AND ProductQuantity <= COALESCE(@ToProductQuantity, ProductQuantity)
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
