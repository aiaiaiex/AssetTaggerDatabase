
CREATE PROCEDURE [test_Constraints].[test_PK_AssetTransfer]
AS
BEGIN
    -- Create dummy data for AssetTransfer.
    EXEC tSQLt.FakeTable '[dbo].[AssetTransfer]';

    DECLARE @AssetTransferID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[AssetTransfer]', '[PK_AssetTransfer]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[AssetTransfer] (AssetTransferID) VALUES
    (@AssetTransferID),
    (@AssetTransferID);
END;