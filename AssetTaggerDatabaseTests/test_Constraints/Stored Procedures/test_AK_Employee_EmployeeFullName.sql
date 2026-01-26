
CREATE PROCEDURE [test_Constraints].[test_AK_Employee_EmployeeFullName]
AS
BEGIN
    -- Create dummy data for Employee.
    EXEC tSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @EmployeeFullName NVARCHAR(50) = 'John Doe';

    -- Apply unique (alternate key) constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Employee]', '[AK_Employee_EmployeeFullName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Employee] (EmployeeFullName) VALUES
    (@EmployeeFullName),
    (@EmployeeFullName);
END;