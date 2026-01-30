CREATE PROCEDURE [test_Constraints].[test_PK_AssetTransfer]
AS
BEGIN
    -- Create dummy data for AssetTransfer.
    EXEC TSQLt.FakeTable '[dbo].[AssetTransfer]';

    DECLARE @AssetTransferID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[AssetTransfer]', '[PK_AssetTransfer]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[AssetTransfer] (AssetTransferID) VALUES
    (@AssetTransferID),
    (@AssetTransferID);
END;
