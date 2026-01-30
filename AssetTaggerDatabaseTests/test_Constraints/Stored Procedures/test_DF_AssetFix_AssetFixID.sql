CREATE PROCEDURE [test_Constraints].[test_DF_AssetFix_AssetFixID]
AS
BEGIN
    -- Create dummy data for AssetFix.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[AssetFix]', @Defaults = 1;

    DECLARE @AssetFixDateStart DATETIME = '2000-01-01';

    INSERT INTO [dbo].[AssetFix] (AssetFixDateStart) VALUES
    (@AssetFixDateStart);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = AssetFixID FROM [dbo].[AssetFix];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
