CREATE PROCEDURE [dbo].[usp_UpdateAssetIssue]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetIssueID UNIQUEIDENTIFIER,
    @AssetID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @AssetIssueDate DATETIMEOFFSET(3) = NULL,
    @AssetIssueTitle NVARCHAR(4000) = NULL,
    @AssetIssueDescription NVARCHAR(MAX) = '',
    @AssetIssueDocumentationURL NVARCHAR(4000) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateAssetIssue BIT = (SELECT UpdateAssetIssue FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateAssetIssue IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@UpdateAssetIssue = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an AssetIssue!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);

    -- Run actual query.
    UPDATE
        [dbo].[AssetIssue]
    SET
        AssetID = ISNULL(@AssetID, AssetID),
        EmployeeID = ISNULL(@EmployeeID, EmployeeID),
        AssetIssueDate = ISNULL(@AssetIssueDate, AssetIssueDate),
        AssetIssueTitle = ISNULL(@AssetIssueTitle, AssetIssueTitle),
        AssetIssueDescription = IIF(@AssetIssueDescription = @NULLISH_NVARCHAR, AssetIssueDescription, @AssetIssueDescription),
        AssetIssueDocumentationURL = IIF(@AssetIssueDocumentationURL = @NULLISH_NVARCHAR, AssetIssueDocumentationURL, @AssetIssueDocumentationURL)
    OUTPUT
        INSERTED.AssetIssueID,
        INSERTED.AssetID,
        INSERTED.EmployeeID,
        INSERTED.AssetIssueDate,
        INSERTED.AssetIssueTitle,
        INSERTED.AssetIssueDescription,
        INSERTED.AssetIssueDocumentationURL,
        DELETED.AssetID AS OldAssetID,
        DELETED.EmployeeID AS OldEmployeeID,
        DELETED.AssetIssueDate AS OldAssetIssueDate,
        DELETED.AssetIssueTitle AS OldAssetIssueTitle,
        DELETED.AssetIssueDescription AS OldAssetIssueDescription,
        DELETED.AssetIssueDocumentationURL AS OldAssetIssueDocumentationURL
    FROM
        [dbo].[AssetIssue]
    WHERE
        AssetIssueID = @AssetIssueID;
END;
