
CREATE PROCEDURE [test_Constraints].[test_FK_EndUser_Employee]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC tSQLt.FakeTable '[dbo].[EndUser]';

    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[EndUser]', '[FK_EndUser_Employee]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[EndUser] (EmployeeID) VALUES
    (NEWID());
END;