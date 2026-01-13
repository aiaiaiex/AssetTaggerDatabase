CREATE PROCEDURE [dbo].[usp_GetCurrentFixedStatusOfAsset]
    @AssetID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        TOP 1
        af.AssetFixed
    FROM [dbo].[Asset] a
    INNER JOIN [dbo].[AssetIssue] ai
        ON ai.AssetID = a.AssetID
    INNER JOIN [dbo].[AssetFix] af
        ON af.AssetIssueID = ai.AssetIssueID
    WHERE a.AssetID = @AssetID
    ORDER BY GREATEST(AssetFixDateStart, AssetFixDateEnd) DESC;
END
GO