
CREATE PROCEDURE [test_Constraints].[test_AK_Product_ProductModelNumber_ProductManufacturer]
AS
BEGIN
    -- Create dummy data for Product.
    EXEC tSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductModelNumber NVARCHAR(50) = 'Product Model Number 01';
    DECLARE @ProductManufacturer NVARCHAR(50) = 'Product Manufacturer 01';

    -- Apply unique (alternate key) constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Product]', '[AK_Product_ProductModelNumber_ProductManufacturer]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Product] (ProductModelNumber, ProductManufacturer) VALUES
    (@ProductModelNumber, @ProductManufacturer),
    (@ProductModelNumber, @ProductManufacturer);
END;