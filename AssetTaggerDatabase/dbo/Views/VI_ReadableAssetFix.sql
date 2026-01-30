CREATE VIEW [dbo].[VI_ReadableAssetFix]
AS
SELECT
    Af.AssetFixID,
    Af.AssetIssueID,
    Ai.AssetIssueTitle,
    P.ProductName,
    Af.AssetFixDateStart,
    Af.AssetFixCost,
    Af.AssetFixDateEnd,
    Af.AssetFixTitle,
    Af.AssetFixDesc,
    Af.AssetFixed,
    Af.EmployeeID,
    E.EmployeeFullName
FROM [dbo].[AssetFix] AS Af
INNER JOIN [dbo].[AssetIssue] AS Ai
    ON Af.AssetIssueID = Ai.AssetIssueID
INNER JOIN [dbo].[Asset] AS A
    ON Ai.AssetID = A.AssetID
INNER JOIN [dbo].[Product] AS P
    ON A.ProductID = P.ProductID
INNER JOIN [dbo].[Employee] AS E
    ON Af.EmployeeID = E.EmployeeID
