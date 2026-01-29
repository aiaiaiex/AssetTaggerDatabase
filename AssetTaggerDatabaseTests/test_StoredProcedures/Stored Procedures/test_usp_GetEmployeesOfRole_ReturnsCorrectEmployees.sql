CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetEmployeesOfRole_ReturnsCorrectEmployees]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @TargetRoleID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherRoleID UNIQUEIDENTIFIER = NEWID();

    DECLARE @Emp1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Emp2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseEmp UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Employee] (EmployeeID, RoleID)
    VALUES
    (@Emp1, @TargetRoleID),
    (@Emp2, @TargetRoleID),
    (@NoiseEmp, @OtherRoleID);

    CREATE TABLE #actual (EmployeeID UNIQUEIDENTIFIER);

    INSERT INTO #actual (EmployeeID)
    EXEC [dbo].[usp_GetEmployeesOfRole] @RoleID = @TargetRoleID;

    CREATE TABLE #expected (EmployeeID UNIQUEIDENTIFIER);
    INSERT INTO #expected (EmployeeID) VALUES (@Emp1), (@Emp2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
