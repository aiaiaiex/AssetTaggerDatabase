CREATE PROCEDURE [dbo].[usp_ReadAssetIssue]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetIssueID UNIQUEIDENTIFIER = NULL,
    @AssetID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @AssetIssueTitle NVARCHAR(4000) = NULL,
    @AssetIssueDescription NVARCHAR(MAX) = '',
    @AssetIssueDocumentationURL NVARCHAR(4000) = '',
    @FromAssetIssueDate DATETIMEOFFSET(3) = NULL,
    @ToAssetIssueDate DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingAssetIssuePermission BIT = (SELECT HasReadingAssetIssuePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasReadingAssetIssuePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingAssetIssuePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read AssetIssue!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NON_NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NON_NULLISH_NVARCHAR FROM [dbo].[VI_NonNullishConstants]);

    -- Run actual query.
    SELECT
        AssetIssueID,
        AssetID,
        EmployeeID,
        AssetIssueDate,
        AssetIssueTitle,
        AssetIssueDescription,
        AssetIssueDocumentationURL
    FROM
        [dbo].[AssetIssue]
    WHERE
        AssetIssueID = ISNULL(@AssetIssueID, AssetIssueID)
        AND AssetID = ISNULL(@AssetID, AssetID)
        AND EmployeeID = ISNULL(@EmployeeID, EmployeeID)
        AND (AssetIssueTitle = ISNULL(@AssetIssueTitle, AssetIssueTitle) OR AssetIssueTitle LIKE @AssetIssueTitle)
        AND (AssetIssueDescription IS NOT DISTINCT FROM IIF(@AssetIssueDescription = @NULLISH_NVARCHAR, AssetIssueDescription, IIF(@AssetIssueDescription = @NON_NULLISH_NVARCHAR, ISNULL(AssetIssueDescription, @NON_NULLISH_NVARCHAR), @AssetIssueDescription)) OR AssetIssueDescription LIKE @AssetIssueDescription)
        AND (@AssetIssueDocumentationURL IS NOT DISTINCT FROM IIF(@AssetIssueDocumentationURL = @NULLISH_NVARCHAR, AssetIssueDocumentationURL, IIF(@AssetIssueDocumentationURL = @NON_NULLISH_NVARCHAR, ISNULL(AssetIssueDocumentationURL, @NON_NULLISH_NVARCHAR), @AssetIssueDocumentationURL)) OR AssetIssueDocumentationURL LIKE @AssetIssueDocumentationURL)
        AND ISNULL(@FromAssetIssueDate, AssetIssueDate) <= AssetIssueDate
        AND AssetIssueDate <= ISNULL(@ToAssetIssueDate, AssetIssueDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN AssetIssueNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN AssetIssueNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
