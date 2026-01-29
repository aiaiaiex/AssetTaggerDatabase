CREATE PROCEDURE [dbo].[usp_GetAssetIssuesOfProduct]
    @ProductID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Ai.AssetIssueID
    FROM [dbo].[AssetIssue] AS Ai
    INNER JOIN [dbo].[Asset] AS A ON Ai.AssetID = A.AssetID
    INNER JOIN [dbo].[Product] AS P ON A.ProductID = P.ProductID
    WHERE A.ProductID = @ProductID;
END
