
CREATE PROCEDURE [test_Constraints].[test_DF_Product_ProductID]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[Product]', @Defaults=1;

    DECLARE @ProductManufacturer NVARCHAR(50) = 'Nvidia';

    INSERT INTO [dbo].[Product] (ProductManufacturer) VALUES
    (@ProductManufacturer);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = ProductID from [dbo].[Product];
    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;