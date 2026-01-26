
CREATE PROCEDURE [test_Constraints].[test_PK_Department]
AS
BEGIN
    -- Create dummy data for Department.
    EXEC tSQLt.FakeTable '[dbo].[Department]';

    DECLARE @DepartmentID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Department]', '[PK_Department]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Department] (DepartmentID) VALUES
    (@DepartmentID),
    (@DepartmentID);
END;