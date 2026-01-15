CREATE PROCEDURE [dbo].[usp_GetEmployeesOfRole]
    @RoleID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        EmployeeID
        -- EmployeeFullName -- Added this so you know WHO the employee is
    FROM [dbo].[Employee]
    WHERE RoleID = @RoleID;
END
