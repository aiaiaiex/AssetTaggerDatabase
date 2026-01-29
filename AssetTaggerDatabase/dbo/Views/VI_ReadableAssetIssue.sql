CREATE VIEW [dbo].[VI_ReadableAssetIssue]
AS
SELECT
    Ai.AssetIssueID,
    Ai.AssetIssueTitle,
    Ai.AssetIssueDesc,
    Ai.AssetIssueDate,
    Ai.AssetID,
    P.ProductName,
    Ai.EmployeeID,
    E.EmployeeFullName
FROM [dbo].[AssetIssue] AS Ai
INNER JOIN [dbo].[Asset] AS A
    ON Ai.AssetID = A.AssetID
INNER JOIN [dbo].[Product] AS P
    ON A.ProductID = P.ProductID
INNER JOIN [dbo].[Employee] AS E
    ON Ai.EmployeeID = E.EmployeeID
