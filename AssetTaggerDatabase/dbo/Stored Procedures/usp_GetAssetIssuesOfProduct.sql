CREATE PROCEDURE [dbo].[usp_GetAssetIssuesOfProduct]
    @ProductID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ai.AssetIssueID
    FROM [dbo].[AssetIssue] ai
    INNER JOIN [dbo].[Asset] a ON a.AssetID = ai.AssetID
    INNER JOIN [dbo].[Product] p ON p.ProductID = a.ProductID
    WHERE a.ProductID = @ProductID;
END
