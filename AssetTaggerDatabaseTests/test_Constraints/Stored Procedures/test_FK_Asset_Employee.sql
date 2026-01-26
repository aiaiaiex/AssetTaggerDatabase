
CREATE PROCEDURE [test_Constraints].[test_FK_Asset_Employee]
AS
BEGIN
    -- Create dummy data for Asset.
    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Asset]', '[FK_Asset_Employee]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Asset] (EmployeeID) VALUES
    (NEWID());
END;