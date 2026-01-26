
CREATE PROCEDURE [test_Constraints].[test_FK_Company_Company]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC tSQLt.FakeTable '[dbo].[Company]';
    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Company]', '[FK_Company_Company]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Company] (ParentCompanyID) VALUES
    (NEWID());
END;