CREATE PROCEDURE [dbo].[usp_CreateAssetFix]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetIssueID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER,
    @AssetFixDateStart DATETIME = NULL,
    @AssetFixDateEnd DATETIME = NULL,
    @AssetFixTitle NVARCHAR(4000),
    @AssetFixDescription NVARCHAR(MAX) = NULL,
    @AssetFixDocumentationURL NVARCHAR(4000) = NULL,
    @AssetFixed BIT,
    @AssetFixCost DECIMAL(19, 4) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateAssetFix BIT = (SELECT CreateAssetFix FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateAssetFix IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateAssetFix = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create an AssetFix!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[AssetFix] (
        AssetIssueID,
        EmployeeID,
        AssetFixDateStart,
        AssetFixDateEnd,
        AssetFixTitle,
        AssetFixDescription,
        AssetFixDocumentationURL,
        AssetFixed,
        AssetFixCost
    )
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
        INSERTED.AssetFixCost
    VALUES (
        @AssetIssueID,
        @EmployeeID,
        ISNULL(@AssetFixDateStart, GETDATE()),
        @AssetFixDateEnd,
        @AssetFixTitle,
        @AssetFixDescription,
        @AssetFixDocumentationURL,
        @AssetFixed,
        @AssetFixCost
    );
END;
