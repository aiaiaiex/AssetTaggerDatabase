
CREATE PROCEDURE [test_Constraints].[test_DF_AssetTransfer_AssetTransferID]
AS
BEGIN
    -- Create dummy data for AssetTransfer.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[AssetTransfer]', @Defaults=1;

    DECLARE @AssetTransferDate DATETIME = '2000-01-01';

    INSERT INTO [dbo].[AssetTransfer] (AssetTransferDate) VALUES
    (@AssetTransferDate);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = AssetTransferID from [dbo].[AssetTransfer];

    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;