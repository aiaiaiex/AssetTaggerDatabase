CREATE PROCEDURE [dbo].[usp_DeleteAssetIssue]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetIssueID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingAssetIssuePermission BIT = (SELECT HasDeletingAssetIssuePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingAssetIssuePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingAssetIssuePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete an AssetIssue!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[AssetIssue]
    OUTPUT
        DELETED.AssetIssueID,
        DELETED.AssetID,
        DELETED.EmployeeID,
        DELETED.AssetIssueDate,
        DELETED.AssetIssueTitle,
        DELETED.AssetIssueDescription,
        DELETED.AssetIssueDocumentationURL
    FROM
        [dbo].[AssetIssue]
    WHERE
        AssetIssueID = @AssetIssueID;
END;
