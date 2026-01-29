CREATE PROCEDURE [test_Constraints].[test_DF_AssetTransfer_AssetTransferID]
AS
BEGIN
    -- Create dummy data for AssetTransfer.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[AssetTransfer]', @Defaults = 1;

    DECLARE @AssetTransferDate DATETIME = '2000-01-01';

    INSERT INTO [dbo].[AssetTransfer] (AssetTransferDate) VALUES
    (@AssetTransferDate);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = AssetTransferID FROM [dbo].[AssetTransfer];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
