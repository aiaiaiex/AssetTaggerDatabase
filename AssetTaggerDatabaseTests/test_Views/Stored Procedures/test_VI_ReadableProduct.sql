
CREATE PROCEDURE [test_Views].[test_VI_ReadableProduct]
AS
BEGIN
    -- Create dummy data for Category.
    EXEC tSQLt.FakeTable '[dbo].[Category]';

    DECLARE @CategoryID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CategoryID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CategoryName01 NVARCHAR(50) = 'Category Name 01';
    DECLARE @CategoryName02 NVARCHAR(50) = 'Category Name 02';

    INSERT INTO [dbo].[Category] (
        CategoryID,
        CategoryName
    ) VALUES
    (
        @CategoryID01,
        @CategoryName01
    ),
    (
        @CategoryID02,
        @CategoryName02
    );

    -- Create dummy data for Product.
    EXEC tSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ProductName01 NVARCHAR(50) = 'Product Name 01';
    DECLARE @ProductName02 NVARCHAR(50) = 'Product Name 02';

    DECLARE @ProductModelNumber01 NVARCHAR(50) = 'Product Model Number 01';
    DECLARE @ProductModelNumber02 NVARCHAR(50) = 'Product Model Number 02';

    DECLARE @ProductManufacturer01 NVARCHAR(50) = 'Product Manufacturer 01';
    DECLARE @ProductManufacturer02 NVARCHAR(50) = 'Product Manufacturer 02';

    INSERT INTO [dbo].[Product] (
        ProductID,
        ProductName,
        ProductModelNumber,
        ProductManufacturer,
        CategoryID
    ) VALUES
    (
        @ProductID01,
        @ProductName01,
        @ProductModelNumber01,
        @ProductManufacturer01,
        @CategoryID02
    ),
    (
        @ProductID02,
        @ProductName02,
        @ProductModelNumber02,
        @ProductManufacturer02,
        @CategoryID01
    );

    -- Expected output.
    CREATE TABLE #expected (
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        ProductModelNumber NVARCHAR(50),
        ProductManufacturer NVARCHAR(50),
        CategoryID UNIQUEIDENTIFIER,
        CategoryName NVARCHAR(50)
    );

    INSERT INTO #expected VALUES
    (
        @ProductID01,
        @ProductName01,
        @ProductModelNumber01,
        @ProductManufacturer01,
        @CategoryID02,
        @CategoryName02
    ),
    (
        @ProductID02,
        @ProductName02,
        @ProductModelNumber02,
        @ProductManufacturer02,
        @CategoryID01,
        @CategoryName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        ProductModelNumber NVARCHAR(50),
        ProductManufacturer NVARCHAR(50),
        CategoryID UNIQUEIDENTIFIER,
        CategoryName NVARCHAR(50)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableProduct];

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;