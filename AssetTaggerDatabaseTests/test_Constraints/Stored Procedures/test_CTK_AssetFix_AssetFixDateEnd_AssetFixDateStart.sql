CREATE PROCEDURE [test_Constraints].[test_CTK_AssetFix_AssetFixDateEnd_AssetFixDateStart]
AS
BEGIN
    -- Create dummy data for AssetFix.
    EXEC TSQLt.FakeTable '[dbo].[AssetFix]';

    -- Apply check constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[AssetFix]', '[CTK_AssetFix_AssetFixDateEnd_AssetFixDateStart]';

    -- Test check constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting unacceptable data.
    INSERT INTO [dbo].[AssetFix] (AssetFixDateEnd, AssetFixDateStart) VALUES
    ('2000-01-01', '2000-01-02');
END;
