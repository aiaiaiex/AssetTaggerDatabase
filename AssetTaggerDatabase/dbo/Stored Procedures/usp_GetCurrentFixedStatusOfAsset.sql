CREATE PROCEDURE [dbo].[usp_GetCurrentFixedStatusOfAsset]
    @AssetID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 Af.AssetFixed
    FROM [dbo].[AssetFix] AS Af
    INNER JOIN [dbo].[AssetIssue] AS Ai
        ON Af.AssetIssueID = Ai.AssetIssueID
    WHERE Ai.AssetID = @AssetID
    ORDER BY GREATEST(Af.AssetFixDateStart, Af.AssetFixDateEnd) DESC;
END
