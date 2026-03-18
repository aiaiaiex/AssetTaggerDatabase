CREATE PROCEDURE [dbo].[usp_CreateAssetIssue]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER,
    @AssetIssueDate DATETIME = NULL,
    @AssetIssueTitle NVARCHAR(4000),
    @AssetIssueDescription NVARCHAR(MAX) = NULL,
    @AssetIssueDocumentationURL NVARCHAR(4000) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateAssetIssue BIT = (SELECT CreateAssetIssue FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateAssetIssue IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateAssetIssue = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create an AssetIssue!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[AssetIssue] (
        AssetID,
        EmployeeID,
        AssetIssueDate,
        AssetIssueTitle,
        AssetIssueDescription,
        AssetIssueDocumentationURL
    )
    OUTPUT
        INSERTED.AssetIssueID,
        INSERTED.AssetID,
        INSERTED.EmployeeID,
        INSERTED.AssetIssueDate,
        INSERTED.AssetIssueTitle,
        INSERTED.AssetIssueDescription,
        INSERTED.AssetIssueDocumentationURL
    VALUES (
        @AssetID,
        @EmployeeID,
        ISNULL(@AssetIssueDate, GETDATE()),
        @AssetIssueTitle,
        @AssetIssueDescription,
        @AssetIssueDocumentationURL
    );
END;
