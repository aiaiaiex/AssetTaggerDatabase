CREATE PROCEDURE [test_Constraints].[test_FK_Asset_Location]
AS
BEGIN
    -- Create dummy data for Asset.
    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Asset]', '[FK_Asset_Location]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Asset] (LocationID) VALUES
    (NEWID());
END;
