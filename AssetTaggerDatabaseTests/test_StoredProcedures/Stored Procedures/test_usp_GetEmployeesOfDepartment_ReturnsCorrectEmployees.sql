CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetEmployeesOfDepartment_ReturnsCorrectEmployees]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @TargetDeptID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherDeptID UNIQUEIDENTIFIER = NEWID();

    DECLARE @Emp1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Emp2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseEmp UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Employee] (EmployeeID, DepartmentID)
    VALUES
    (@Emp1, @TargetDeptID),
    (@Emp2, @TargetDeptID),
    (@NoiseEmp, @OtherDeptID);

    CREATE TABLE #actual (EmployeeID UNIQUEIDENTIFIER);

    INSERT INTO #actual (EmployeeID)
    EXEC [dbo].[usp_GetEmployeesOfDepartment] @DepartmentID = @TargetDeptID;

    CREATE TABLE #expected (EmployeeID UNIQUEIDENTIFIER);
    INSERT INTO #expected (EmployeeID) VALUES (@Emp1), (@Emp2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
