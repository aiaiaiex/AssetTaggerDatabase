CREATE PROCEDURE [test_Constraints].[test_DF_AssetFix_AssetFixDateStart]
AS
BEGIN
    -- Create dummy data for AssetFix.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[AssetFix]', @Defaults = 1;

    DECLARE @AssetFixTitle NVARCHAR(50) = 'Hardware Repair';

    INSERT INTO [dbo].[AssetFix] (AssetFixTitle) VALUES
    (@AssetFixTitle);

    -- Actual ouput.
    DECLARE @actual DATETIME;
    SELECT @actual = AssetFixDateStart FROM [dbo].[AssetFix];
    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
