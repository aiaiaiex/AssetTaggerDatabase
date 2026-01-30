CREATE PROCEDURE [test_Constraints].[test_DF_Product_ProductID]
AS
BEGIN
    -- Create dummy data for Product.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Product]', @Defaults = 1;

    DECLARE @ProductName NVARCHAR(50) = 'Product Name 01';

    INSERT INTO [dbo].[Product] (ProductName) VALUES
    (@ProductName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = ProductID FROM [dbo].[Product];
    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
