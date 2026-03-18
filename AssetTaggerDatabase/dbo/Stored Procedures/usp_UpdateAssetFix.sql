CREATE PROCEDURE [dbo].[usp_UpdateAssetFix]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetFixID UNIQUEIDENTIFIER,
    @AssetIssueID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @AssetFixDateStart DATETIME = NULL,
    @AssetFixDateEnd DATETIME = '1753-01-01 00:00:00.000',
    @AssetFixTitle NVARCHAR(4000) = NULL,
    @AssetFixDescription NVARCHAR(MAX) = '',
    @AssetFixDocumentationURL NVARCHAR(4000) = '',
    @AssetFixed BIT = NULL,
    @AssetFixCost DECIMAL(19, 4) = -999999999999999.9999
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateAssetFix BIT = (SELECT UpdateAssetFix FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateAssetFix IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@UpdateAssetFix = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an AssetFix!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DATETIME DATETIME = (SELECT NULLISH_DATETIME FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DECIMAL DECIMAL(19, 4) = (SELECT NULLISH_DECIMAL FROM [dbo].[VI_NullishConstants]);

    -- Run actual query.
    UPDATE
        [dbo].[AssetFix]
    SET
        AssetIssueID = ISNULL(@AssetIssueID, AssetIssueID),
        EmployeeID = ISNULL(@EmployeeID, EmployeeID),
        AssetFixDateStart = ISNULL(@AssetFixDateStart, AssetFixDateStart),
        AssetFixDateEnd = IIF(@AssetFixDateEnd = @NULLISH_DATETIME, AssetFixDateEnd, @AssetFixDateEnd),
        AssetFixTitle = ISNULL(@AssetFixTitle, AssetFixTitle),
        AssetFixDescription = IIF(@AssetFixDescription = @NULLISH_NVARCHAR, AssetFixDescription, @AssetFixDescription),
        AssetFixDocumentationURL = IIF(@AssetFixDocumentationURL = @NULLISH_NVARCHAR, AssetFixDocumentationURL, @AssetFixDocumentationURL),
        AssetFixed = ISNULL(@AssetFixed, AssetFixed),
        AssetFixCost = IIF(@AssetFixCost = @NULLISH_DECIMAL, AssetFixCost, @AssetFixCost)
    OUTPUT
        INSERTED.AssetFixID,
        INSERTED.AssetIssueID,
        INSERTED.EmployeeID,
        INSERTED.AssetFixDateStart,
        INSERTED.AssetFixDateEnd,
        INSERTED.AssetFixTitle,
        INSERTED.AssetFixDescription,
        INSERTED.AssetFixDocumentationURL,
        INSERTED.AssetFixed,
        INSERTED.AssetFixCost,
        DELETED.AssetIssueID AS OldAssetIssueID,
        DELETED.EmployeeID AS OldEmployeeID,
        DELETED.AssetFixDateStart AS OldAssetFixDateStart,
        DELETED.AssetFixDateEnd AS OldAssetFixDateEnd,
        DELETED.AssetFixTitle AS OldAssetFixTitle,
        DELETED.AssetFixDescription AS OldAssetFixDescription,
        DELETED.AssetFixDocumentationURL AS OldAssetFixDocumentationURL,
        DELETED.AssetFixed AS OldAssetFixed,
        DELETED.AssetFixCost AS OldAssetFixCost
    FROM
        [dbo].[AssetFix]
    WHERE
        AssetFixID = @AssetFixID;
END;
