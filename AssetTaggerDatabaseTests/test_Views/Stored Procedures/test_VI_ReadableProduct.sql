CREATE PROCEDURE [test_Views].[test_VI_ReadableProduct]
AS
BEGIN
    -- Create dummy data for Manufacturer.
    EXEC TSQLt.FakeTable '[dbo].[Manufacturer]';

    DECLARE @ManufacturerID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ManufacturerID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ManufacturerName01 NVARCHAR(4000) = 'Manufacturer Name 01';
    DECLARE @ManufacturerName02 NVARCHAR(4000) = 'Manufacturer Name 02';

    INSERT INTO [dbo].[Manufacturer] (
        ManufacturerID,
        ManufacturerName
    ) VALUES
    (
        @ManufacturerID01,
        @ManufacturerName01
    ),
    (
        @ManufacturerID02,
        @ManufacturerName02
    );

    -- Create dummy data for Category.
    EXEC TSQLt.FakeTable '[dbo].[Category]';

    DECLARE @CategoryID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CategoryID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CategoryName01 NVARCHAR(4000) = 'Category Name 01';
    DECLARE @CategoryName02 NVARCHAR(4000) = 'Category Name 02';

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
    EXEC TSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ProductName01 NVARCHAR(4000) = 'Product Name 01';
    DECLARE @ProductName02 NVARCHAR(4000) = 'Product Name 02';

    DECLARE @ProductModelNumber01 NVARCHAR(4000) = 'Product Model Number 01';
    DECLARE @ProductModelNumber02 NVARCHAR(4000) = 'Product Model Number 02';

    INSERT INTO [dbo].[Product] (
        ProductID,
        ProductName,
        ProductModelNumber,
        ManufacturerID,
        CategoryID
    ) VALUES
    (
        @ProductID01,
        @ProductName01,
        @ProductModelNumber01,
        @ManufacturerID02,
        @CategoryID02
    ),
    (
        @ProductID02,
        @ProductName02,
        @ProductModelNumber02,
        @ManufacturerID01,
        @CategoryID01
    );

    -- Expected output.
    CREATE TABLE #expected (
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(4000),
        ProductModelNumber NVARCHAR(4000),
        ManufacturerID UNIQUEIDENTIFIER,
        ManufacturerName NVARCHAR(4000),
        CategoryID UNIQUEIDENTIFIER,
        CategoryName NVARCHAR(4000)
    );

    INSERT INTO #expected VALUES
    (
        @ProductID01,
        @ProductName01,
        @ProductModelNumber01,
        @ManufacturerID02,
        @ManufacturerName02,
        @CategoryID02,
        @CategoryName02
    ),
    (
        @ProductID02,
        @ProductName02,
        @ProductModelNumber02,
        @ManufacturerID01,
        @ManufacturerName01,
        @CategoryID01,
        @CategoryName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(4000),
        ProductModelNumber NVARCHAR(4000),
        ManufacturerID UNIQUEIDENTIFIER,
        ManufacturerName NVARCHAR(4000),
        CategoryID UNIQUEIDENTIFIER,
        CategoryName NVARCHAR(4000)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableProduct];

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
