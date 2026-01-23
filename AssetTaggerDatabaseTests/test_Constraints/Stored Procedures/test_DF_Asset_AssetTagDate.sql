
CREATE PROCEDURE [test_Constraints].[test_DF_Asset_AssetTagDate]
AS
BEGIN
    -- Create dummy data for Asset.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[Asset]', @Defaults=1;

    DECLARE @AssetPurchaseDate DATETIME = '2000-01-01';

    INSERT INTO [dbo].[Asset] (AssetPurchaseDate) VALUES
    (@AssetPurchaseDate);

    -- Actual ouput.
    DECLARE @actual DATETIME;
    SELECT @actual = AssetTagDate from [dbo].[Asset];

    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;