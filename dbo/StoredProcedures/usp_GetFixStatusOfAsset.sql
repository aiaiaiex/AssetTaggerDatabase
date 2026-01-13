CREATE PROCEDURE [dbo].[usp_GetFixStatusOfAsset]
    @AssetFixID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        af.AssetFixID,
        af.AssetIssueID,
        ai.AssetID
    FROM [dbo].[AssetFix] af
    INNER JOIN [dbo].[AssetIssue] ai
        ON af.AssetIssueID = ai.AssetIssueID
    WHERE af.AssetFixID = @AssetFixID;
END
GO

