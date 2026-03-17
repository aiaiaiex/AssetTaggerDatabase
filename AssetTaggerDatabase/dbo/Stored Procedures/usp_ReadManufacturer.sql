CREATE PROCEDURE [dbo].[usp_ReadManufacturer]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ManufacturerID UNIQUEIDENTIFIER = NULL,
    @ManufacturerName NVARCHAR(850) = NULL,
    @FromManufacturerInsertDate DATETIME = NULL,
    @ToManufacturerInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadManufacturer BIT;
    SELECT @ReadManufacturer = (SELECT ReadManufacturer FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadManufacturer IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@ReadManufacturer = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Manufacturer!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    SELECT
        ManufacturerID,
        ManufacturerName,
        ManufacturerInsertDate
    FROM [dbo].[Manufacturer]
    WHERE ManufacturerID = ISNULL(@ManufacturerID, ManufacturerID) AND ManufacturerName = ISNULL(@ManufacturerName, ManufacturerName) AND ISNULL(@FromManufacturerInsertDate, ManufacturerInsertDate) <= ManufacturerInsertDate AND ManufacturerInsertDate <= ISNULL(@ToManufacturerInsertDate, ManufacturerInsertDate)
    ORDER BY
        CASE WHEN @NewestRowsFirst = 1 THEN ManufacturerNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN ManufacturerNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END
