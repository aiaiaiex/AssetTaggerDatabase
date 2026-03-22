CREATE PROCEDURE [dbo].[usp_DeleteAssetFix]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetFixID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteAssetFix BIT = (SELECT DeleteAssetFix FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteAssetFix IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteAssetFix = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete an AssetFix!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[AssetFix]
    OUTPUT
        DELETED.AssetFixID,
        DELETED.AssetIssueID,
        DELETED.EmployeeID,
        DELETED.AssetFixDateStart,
        DELETED.AssetFixDateEnd,
        DELETED.AssetFixDateDays,
        DELETED.AssetFixTitle,
        DELETED.AssetFixDescription,
        DELETED.AssetFixDocumentationURL,
        DELETED.AssetFixed,
        DELETED.AssetFixCost
    FROM
        [dbo].[AssetFix]
    WHERE
        AssetFixID = @AssetFixID;
END;
