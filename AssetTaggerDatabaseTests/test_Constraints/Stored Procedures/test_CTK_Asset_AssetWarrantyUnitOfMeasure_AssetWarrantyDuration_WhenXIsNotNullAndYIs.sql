
CREATE PROCEDURE [test_Constraints].[test_CTK_Asset_AssetWarrantyUnitOfMeasure_AssetWarrantyDuration_WhenXIsNotNullAndYIs]
AS
BEGIN
    -- Create dummy data for Asset.
    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    -- Apply check constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Asset]', '[CTK_Asset_AssetWarrantyUnitOfMeasure_AssetWarrantyDuration]';

    -- Test check constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting unacceptable data.
    INSERT INTO [dbo].[Asset] (AssetWarrantyUnitOfMeasure, AssetWarrantyDuration) VALUES
    ('yy', NULL);
END;