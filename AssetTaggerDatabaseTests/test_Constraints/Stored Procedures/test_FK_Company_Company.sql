CREATE PROCEDURE [test_Constraints].[test_FK_Company_Company]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';
    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Company]', '[FK_Company_Company]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Company] (ParentCompanyID) VALUES
    (NEWID());
END;
