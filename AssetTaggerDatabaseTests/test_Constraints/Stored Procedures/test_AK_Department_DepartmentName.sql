CREATE PROCEDURE [test_Constraints].[test_AK_Department_DepartmentName]
AS
BEGIN
    -- Create dummy data for Department.
    EXEC TSQLt.FakeTable '[dbo].[Department]';

    DECLARE @DepartmentName NVARCHAR(50) = 'Department Name 1';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Department]', '[AK_Department_DepartmentName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Department] (DepartmentName) VALUES
    (@DepartmentName),
    (@DepartmentName);
END;
EXEC TSQLt.Run 'test_Constraints.test_AK_Department_DepartmentName';
-- EXEC tSQLt.RunAll;
