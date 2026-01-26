
CREATE PROCEDURE [test_Constraints].[test_CK_Asset_AssetWarrantyUnitOfMeasure]
AS
BEGIN
    -- Create dummy data for Asset.
    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    -- Apply check constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Asset]', '[CK_Asset_AssetWarrantyUnitOfMeasure]';
    -- Test check constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting unacceptable data.
    INSERT INTO [dbo].[Asset] (AssetWarrantyUnitOfMeasure) VALUES
    ('JD');
END;