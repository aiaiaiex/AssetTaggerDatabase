
CREATE PROCEDURE [test_Constraints].[test_PK_AssetFix]
AS
BEGIN
    -- Create dummy data for AssetFix.
    EXEC tSQLt.FakeTable '[dbo].[AssetFix]';

    DECLARE @AssetFixID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[AssetFix]', '[PK_AssetFix]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[AssetFix] (AssetFixID) VALUES
    (@AssetFixID),
    (@AssetFixID);
END;