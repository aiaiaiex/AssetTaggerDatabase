
CREATE PROCEDURE [test_Constraints].[test_CK_AssetFix_AssetFixCost]
AS
BEGIN
    -- Create dummy data for AssetFix.
    EXEC tSQLt.FakeTable '[dbo].[AssetFix]';

    -- Apply check constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[AssetFix]', '[CK_AssetFix_AssetFixCost]';
    -- Test check constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting unacceptable data.
    INSERT INTO [dbo].[AssetFix] (AssetFixCost) VALUES
    (-1);
END;