CREATE PROCEDURE [test_Constraints].[test_FK_EndUser_Employee]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[EndUser]', '[FK_EndUser_Employee]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[EndUser] (EmployeeID) VALUES
    (NEWID());
END;
