

CREATE PROCEDURE [test_Constraints].[test_AK_Department_DepartmentName]
AS
BEGIN
    -- Create dummy data for Department.
    EXEC tSQLt.FakeTable '[dbo].[Department]';

    DECLARE @DepartmentName NVARCHAR(50) = 'Department Name 1';

    -- Apply unique (alternate key) constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Department]', '[AK_Department_DepartmentName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Department] (DepartmentName) VALUES
    (@DepartmentName),
    (@DepartmentName);
END;
EXEC tSQLt.Run 'test_Constraints.test_AK_Department_DepartmentName';
-- EXEC tSQLt.RunAll;