CREATE PROCEDURE [test_Constraints].[test_FK_Asset_Vendor]
AS
BEGIN
    -- Create dummy data for Asset.
    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Asset]', '[FK_Asset_Vendor]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Asset] (VendorID) VALUES
    (NEWID());
END;
