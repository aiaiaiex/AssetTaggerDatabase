CREATE PROCEDURE [test_Constraints].[test_FK_Employee_Role]
AS
BEGIN
    -- Create dummy data for Employee.
    EXEC TSQLt.FakeTable '[dbo].[Employee]';

    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Employee]', '[FK_Employee_Role]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Employee] (RoleID) VALUES
    (NEWID());
END;
