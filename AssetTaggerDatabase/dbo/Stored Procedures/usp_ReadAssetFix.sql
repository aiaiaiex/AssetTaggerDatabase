CREATE PROCEDURE [dbo].[usp_ReadAssetFix]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetFixID UNIQUEIDENTIFIER = NULL, --
    @AssetIssueID UNIQUEIDENTIFIER = NULL, --
    @EmployeeID UNIQUEIDENTIFIER = NULL, --
    @AssetFixTitle NVARCHAR(4000) = NULL, --
    @AssetFixDescription NVARCHAR(MAX) = '', --
    @AssetFixDocumentationURL NVARCHAR(4000) = '', --
    @AssetFixed BIT = NULL, --
    @FromAssetFixDateStart DATETIME = NULL, --
    @ToAssetFixDateStart DATETIME = NULL, --
    @FromAssetFixDateEnd DATETIME = '1753-01-01 00:00:00.000', --
    @ToAssetFixDateEnd DATETIME = '1753-01-01 00:00:00.000', --
    @FromAssetFixCost DECIMAL(19, 4) = -999999999999999.9999,
    @ToAssetFixCost DECIMAL(19, 4) = -999999999999999.9999,
    @RowsToSkip INT = NULL, --
    @RowsToReturn INT = NULL, --
    @NewestRowsFirst BIT = 1 --
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadAssetFix BIT = (SELECT ReadAssetFix FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadAssetFix IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadAssetFix = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read AssetFix!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DATETIME DATETIME = (SELECT NULLISH_DATETIME FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DECIMAL DECIMAL(19, 4) = (SELECT NULLISH_DECIMAL FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DATETIME DATETIME = (SELECT NON_NULLISH_DATETIME FROM [dbo].[VI_NonNullishConstants]);
    DECLARE @NON_NULLISH_DECIMAL DECIMAL(19, 4) = (SELECT NON_NULLISH_DECIMAL FROM [dbo].[VI_NonNullishConstants]);

    -- Run actual query.
    SELECT
        AssetFixID,
        AssetIssueID,
        EmployeeID,
        AssetFixDateStart,
        AssetFixDateEnd,
        AssetFixTitle,
        AssetFixDescription,
        AssetFixDocumentationURL,
        AssetFixed,
        AssetFixCost
    FROM
        [dbo].[AssetFix]
    WHERE
        AssetFixID = ISNULL(@AssetFixID, AssetFixID)
        AND AssetIssueID = ISNULL(@AssetIssueID, AssetIssueID)
        AND EmployeeID = ISNULL(@EmployeeID, EmployeeID)
        AND (AssetFixTitle = ISNULL(@AssetFixTitle, AssetFixTitle) OR AssetFixTitle LIKE @AssetFixTitle)
        AND (AssetFixDescription IS NOT DISTINCT FROM IIF(@AssetFixDescription = @NULLISH_NVARCHAR, AssetFixDescription, IIF(@AssetFixDescription = @NON_NULLISH_NVARCHAR, ISNULL(AssetFixDescription, @NON_NULLISH_NVARCHAR), @AssetFixDescription)) OR AssetFixDescription LIKE @AssetFixDescription)
        AND (@AssetFixDocumentationURL IS NOT DISTINCT FROM IIF(@AssetFixDocumentationURL = @NULLISH_NVARCHAR, AssetFixDocumentationURL, IIF(@AssetFixDocumentationURL = @NON_NULLISH_NVARCHAR, ISNULL(AssetFixDocumentationURL, @NON_NULLISH_NVARCHAR), @AssetFixDocumentationURL)) OR AssetFixDocumentationURL LIKE @AssetFixDocumentationURL)
        AND AssetFixed = ISNULL(@AssetFixed, AssetFixed)
        AND ISNULL(@FromAssetFixDateStart, AssetFixDateStart) <= AssetFixDateStart
        AND AssetFixDateStart <= ISNULL(@ToAssetFixDateStart, AssetFixDateStart)
        AND (IIF(@FromAssetFixDateEnd IN (@NULLISH_DATETIME, @NON_NULLISH_DATETIME), AssetFixDateEnd, @FromAssetFixDateEnd) <= AssetFixDateEnd OR AssetFixDateEnd IS NOT DISTINCT FROM IIF(@FromAssetFixDateEnd = @NON_NULLISH_DATETIME, @NON_NULLISH_DATETIME, NULL))
        AND (AssetFixDateEnd <= IIF(@ToAssetFixDateEnd IN (@NULLISH_DATETIME, @NON_NULLISH_DATETIME), AssetFixDateEnd, @ToAssetFixDateEnd) OR AssetFixDateEnd IS NOT DISTINCT FROM IIF(@ToAssetFixDateEnd = @NON_NULLISH_DATETIME, @NON_NULLISH_DATETIME, NULL))
        AND (IIF(@FromAssetFixCost IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetFixCost, @FromAssetFixCost) <= AssetFixCost OR AssetFixCost IS NOT DISTINCT FROM IIF(@FromAssetFixCost = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
        AND (AssetFixCost <= IIF(@ToAssetFixCost IN (@NULLISH_DECIMAL, @NON_NULLISH_DECIMAL), AssetFixCost, @ToAssetFixCost) OR AssetFixCost IS NOT DISTINCT FROM IIF(@ToAssetFixCost = @NON_NULLISH_DECIMAL, @NON_NULLISH_DECIMAL, NULL))
    ORDER BY
        CASE WHEN @NewestRowsFirst = 1 THEN AssetFixNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN AssetFixNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
