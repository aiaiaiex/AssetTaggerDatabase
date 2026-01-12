CREATE VIEW [dbo].[ReadableEmployee]
AS
  SELECT e.EmployeeID, e.EmployeeFullName, e.RoleID, r.RoleName, e.CompanyID, c.CompanyName, e.DepartmentID, d.DepartmentName
  FROM [dbo].[Employee] e
  INNER JOIN [dbo].[Role] r
    ON r.RoleID = e.RoleID
  INNER JOIN [dbo].[Company] c
    ON c.CompanyID = e.CompanyID
  INNER JOIN [dbo].[Department] d
    ON d.DepartmentID = e.DepartmentID
GO

