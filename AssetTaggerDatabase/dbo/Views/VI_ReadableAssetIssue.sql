CREATE VIEW [dbo].[VI_ReadableAssetIssue]
AS
  SELECT ai.AssetIssueID, ai.AssetIssueTitle, ai.AssetIssueDesc, ai.AssetIssueDate, ai.AssetID, p.ProductName, ai.EmployeeID, e.EmployeeFullName
  FROM [dbo].[AssetIssue] ai
  INNER JOIN [dbo].[Asset] a
    ON a.AssetID = ai.AssetID
  INNER JOIN [dbo].[Product] p
    ON p.ProductID = a.ProductID
  INNER JOIN [dbo].[Employee] e
    ON e.EmployeeID = ai.EmployeeID
