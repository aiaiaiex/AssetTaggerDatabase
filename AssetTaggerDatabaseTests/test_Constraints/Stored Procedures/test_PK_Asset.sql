CREATE PROCEDURE [test_Constraints].[test_PK_Asset]
AS
BEGIN
    -- Create dummy data for Asset.
    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Asset]', '[PK_Asset]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Asset] (AssetID) VALUES
    (@AssetID),
    (@AssetID);
END;
