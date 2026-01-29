CREATE PROCEDURE [test_Constraints].[test_PK_Department]
AS
BEGIN
    -- Create dummy data for Department.
    EXEC TSQLt.FakeTable '[dbo].[Department]';

    DECLARE @DepartmentID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Department]', '[PK_Department]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Department] (DepartmentID) VALUES
    (@DepartmentID),
    (@DepartmentID);
END;
