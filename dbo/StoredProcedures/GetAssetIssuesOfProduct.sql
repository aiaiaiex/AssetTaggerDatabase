CREATE PROCEDURE [dbo].[GetAssetIssuesOfProduct]
    @AssetIssueID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ai.AssetIssueID,
        ai.AssetID,
        a.ProductID
    FROM [dbo].[AssetIssue] ai
    INNER JOIN [dbo].[Asset] a ON ai.AssetID = a.AssetID
    WHERE ai.AssetIssueID = @AssetIssueID;
END
GO

