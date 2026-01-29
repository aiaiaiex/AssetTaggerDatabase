CREATE PROCEDURE [test_Constraints].[test_FK_AssetIssue_Asset]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    EXEC TSQLt.FakeTable '[dbo].[AssetIssue]';
    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[AssetIssue]', '[FK_AssetIssue_Asset]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[AssetIssue] (AssetID) VALUES
    (NEWID());
END;
