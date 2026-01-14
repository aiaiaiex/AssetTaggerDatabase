CREATE VIEW [dbo].[VI_ReadableAssetFix]
AS
  SELECT af.AssetFixID, af.AssetIssueID, ai.AssetIssueTitle, p.ProductName, af.AssetFixDateStart, af.AssetFixCost, af.AssetFixDateEnd, af.AssetFixTitle, af.AssetFixDesc, af.AssetFixed, af.EmployeeID, e.EmployeeFullName
  FROM [dbo].[AssetFix] af
  INNER JOIN [dbo].[AssetIssue] ai
    ON ai.AssetIssueID = af.AssetIssueID
  INNER JOIN [dbo].[Asset] a
    ON a.AssetID = ai.AssetID
  INNER JOIN [dbo].[Product] p
    ON p.ProductID = a.ProductID
  INNER JOIN [dbo].[Employee] e
    ON e.EmployeeID = af.EmployeeID
GO

