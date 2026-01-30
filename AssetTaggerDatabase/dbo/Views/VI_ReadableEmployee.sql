CREATE VIEW [dbo].[VI_ReadableEmployee]
AS
SELECT
    E.EmployeeID,
    E.EmployeeFullName,
    E.RoleID,
    R.RoleName,
    E.CompanyID,
    C.CompanyName,
    E.DepartmentID,
    D.DepartmentName
FROM [dbo].[Employee] AS E
INNER JOIN [dbo].[Role] AS R
    ON E.RoleID = R.RoleID
INNER JOIN [dbo].[Company] AS C
    ON E.CompanyID = C.CompanyID
INNER JOIN [dbo].[Department] AS D
    ON E.DepartmentID = D.DepartmentID
