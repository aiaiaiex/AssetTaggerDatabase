CREATE PROCEDURE [dbo].[usp_UpdateAssetFix]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetFixID UNIQUEIDENTIFIER,
    @AssetIssueID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @AssetFixDateStart DATETIMEOFFSET(3) = NULL,
    @AssetFixDateEnd DATETIMEOFFSET(3) = '1900-01-01T00:00:00.000Z',
    @AssetFixTitle NVARCHAR(4000) = NULL,
    @AssetFixDescription NVARCHAR(MAX) = '',
    @AssetFixDocumentationURL NVARCHAR(4000) = '',
    @AssetFixed BIT = NULL,
    @AssetFixCost DECIMAL(15, 4) = -99999999999.9999
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingAssetFixPermission BIT = (SELECT HasUpdatingAssetFixPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingAssetFixPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingAssetFixPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an AssetFix!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DATETIMEOFFSET DATETIMEOFFSET(3) = (SELECT NULLISH_DATETIMEOFFSET FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DECIMAL DECIMAL(15, 4) = (SELECT NULLISH_DECIMAL FROM [dbo].[VI_NullishConstants]);

    -- Run actual query.
    UPDATE
        [dbo].[AssetFix]
    SET
        AssetIssueID = ISNULL(@AssetIssueID, AssetIssueID),
        EmployeeID = ISNULL(@EmployeeID, EmployeeID),
        AssetFixDateStart = ISNULL(@AssetFixDateStart, AssetFixDateStart),
        AssetFixDateEnd = IIF(@AssetFixDateEnd = @NULLISH_DATETIMEOFFSET, AssetFixDateEnd, @AssetFixDateEnd),
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
        INSERTED.AssetFixDateDays,
        INSERTED.AssetFixTitle,
        INSERTED.AssetFixDescription,
        INSERTED.AssetFixDocumentationURL,
        INSERTED.AssetFixed,
        INSERTED.AssetFixCost,
        DELETED.AssetIssueID AS OldAssetIssueID,
        DELETED.EmployeeID AS OldEmployeeID,
        DELETED.AssetFixDateStart AS OldAssetFixDateStart,
        DELETED.AssetFixDateEnd AS OldAssetFixDateEnd,
        DELETED.AssetFixDateDays AS OldAssetFixDateDays,
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
