CREATE PROCEDURE [test_Constraints].[test_AK_Product_ProductModelNumber_ManufacturerID]
AS
BEGIN
    -- Create dummy data for Product.
    EXEC TSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductModelNumber NVARCHAR(50) = 'Product Model Number 01';
    DECLARE @ManufacturerID UNIQUEIDENTIFIER = NEWID();

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Product]', '[AK_Product_ProductModelNumber_ManufacturerID]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Product] (ProductModelNumber, ManufacturerID) VALUES
    (@ProductModelNumber, @ManufacturerID),
    (@ProductModelNumber, @ManufacturerID);
END;
