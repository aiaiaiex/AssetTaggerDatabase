CREATE PROCEDURE [dbo].[usp_ReadVendor]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @VendorID UNIQUEIDENTIFIER = NULL,
    @VendorName NVARCHAR(850) = NULL,
    @VendorAddress NVARCHAR(850) = NULL,
    @FromVendorInsertDate DATETIME = NULL,
    @ToVendorInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = 1
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadVendor BIT = (SELECT ReadVendor FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadVendor IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadVendor = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Vendor!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    SELECT
        VendorID,
        VendorName,
        VendorAddress,
        VendorInsertDate
    FROM
        [dbo].[Vendor]
    WHERE
        VendorID = ISNULL(@VendorID, VendorID)
        AND VendorName = ISNULL(@VendorName, VendorName)
        AND VendorAddress = ISNULL(@VendorAddress, VendorAddress)
        AND ISNULL(@FromVendorInsertDate, VendorInsertDate) <= VendorInsertDate
        AND VendorInsertDate <= ISNULL(@ToVendorInsertDate, VendorInsertDate)
    ORDER BY
        CASE WHEN @NewestRowsFirst = 1 THEN VendorNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN VendorNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
