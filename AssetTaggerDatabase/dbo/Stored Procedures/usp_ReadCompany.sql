CREATE PROCEDURE [dbo].[usp_ReadCompany]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @CompanyID UNIQUEIDENTIFIER = NULL,
    @CompanyName NVARCHAR(850) = NULL,
    @CompanyAddress NVARCHAR(850) = NULL,
    @CompanyCode NVARCHAR(5) = NULL,
    @ParentCompanyID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @FromCompanyInsertDate DATETIME = NULL,
    @ToCompanyInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadCompany BIT = (SELECT ReadCompany FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadCompany IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadCompany = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Company!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);

    -- Run actual query.
    SELECT
        CompanyID,
        CompanyName,
        CompanyAddress,
        CompanyCode,
        ParentCompanyID,
        CompanyInsertDate
    FROM
        [dbo].[Company]
    WHERE
        CompanyID = ISNULL(@CompanyID, CompanyID)
        AND (CompanyName = ISNULL(@CompanyName, CompanyName) OR CompanyName LIKE @CompanyName)
        AND (CompanyAddress = ISNULL(@CompanyAddress, CompanyAddress) OR CompanyAddress LIKE @CompanyAddress)
        AND (CompanyCode = ISNULL(@CompanyCode, CompanyCode) OR CompanyCode LIKE @CompanyCode)
        AND ParentCompanyID IS NOT DISTINCT FROM IIF(@ParentCompanyID = @NULLISH_UNIQUEIDENTIFIER, ParentCompanyID, IIF(@ParentCompanyID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(ParentCompanyID, @NON_NULLISH_UNIQUEIDENTIFIER), @ParentCompanyID))
        AND ISNULL(@FromCompanyInsertDate, CompanyInsertDate) <= CompanyInsertDate
        AND CompanyInsertDate <= ISNULL(@ToCompanyInsertDate, CompanyInsertDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN CompanyNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN CompanyNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
