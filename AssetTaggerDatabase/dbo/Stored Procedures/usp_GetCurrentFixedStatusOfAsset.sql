
CREATE PROCEDURE [dbo].[usp_GetCurrentFixedStatusOfAsset]
    @AssetID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        TOP 1
        af.AssetFixed
    FROM [dbo].[AssetFix] af
    INNER JOIN [dbo].[AssetIssue] ai
        ON ai.AssetIssueID = af.AssetIssueID
    WHERE ai.AssetID = @AssetID
    ORDER BY GREATEST(af.AssetFixDateStart, af.AssetFixDateEnd) DESC;
END