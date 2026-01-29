CREATE PROCEDURE [test_Constraints].[test_PK_Employee]
AS
BEGIN
    -- Create dummy data for Employee.
    EXEC TSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @EmployeeID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Employee]', '[PK_Employee]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Employee] (EmployeeID) VALUES
    (@EmployeeID),
    (@EmployeeID);
END;
