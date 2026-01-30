CREATE PROCEDURE [dbo].[usp_GetEmployeesOfDepartment]
    @DepartmentID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID
    FROM [dbo].[Employee]
    WHERE DepartmentID = @DepartmentID;
END
