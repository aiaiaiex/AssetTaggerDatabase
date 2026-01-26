
CREATE PROCEDURE [test_Constraints].[test_FK_Employee_Company]
AS
BEGIN
    -- Create dummy data for Employee.
    EXEC tSQLt.FakeTable '[dbo].[Employee]';

    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Employee]', '[FK_Employee_Company]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Employee] (CompanyID) VALUES
    (NEWID());
END;