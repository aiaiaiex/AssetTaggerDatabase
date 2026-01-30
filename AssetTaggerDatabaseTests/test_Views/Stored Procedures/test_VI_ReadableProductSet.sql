CREATE PROCEDURE [test_Views].[test_VI_ReadableProductSet]
AS
BEGIN
    -- Create dummy data for Product.
    EXEC TSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID03 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID04 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID05 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID06 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID07 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID08 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID09 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ProductName01 NVARCHAR(50) = 'Product Name 01';
    DECLARE @ProductName02 NVARCHAR(50) = 'Product Name 02';
    DECLARE @ProductName03 NVARCHAR(50) = 'Product Name 03';
    DECLARE @ProductName04 NVARCHAR(50) = 'Product Name 04';
    DECLARE @ProductName05 NVARCHAR(50) = 'Product Name 05';
    DECLARE @ProductName06 NVARCHAR(50) = 'Product Name 06';
    DECLARE @ProductName07 NVARCHAR(50) = 'Product Name 07';
    DECLARE @ProductName08 NVARCHAR(50) = 'Product Name 08';
    DECLARE @ProductName09 NVARCHAR(50) = 'Product Name 09';

    INSERT INTO [dbo].[Product] (ProductID, ProductName) VALUES
    (@ProductID01, @ProductName01),
    (@ProductID02, @ProductName02),
    (@ProductID03, @ProductName03),
    (@ProductID04, @ProductName04),
    (@ProductID05, @ProductName05),
    (@ProductID06, @ProductName06),
    (@ProductID07, @ProductName07),
    (@ProductID08, @ProductName08),
    (@ProductID09, @ProductName09);

    -- Create dummy data for ProductSet.
    EXEC TSQLt.FakeTable '[dbo].[ProductSet]';

    INSERT INTO [dbo].[ProductSet] (ParentProductID, ProductID) VALUES
    (@ProductID01, @ProductID02),
    (@ProductID03, @ProductID04),
    (@ProductID03, @ProductID05),
    (@ProductID06, @ProductID07),
    (@ProductID06, @ProductID08),
    (@ProductID06, @ProductID09);

    -- Expected output.
    CREATE TABLE #expected (
        ParentProductID UNIQUEIDENTIFIER,
        ParentProductName NVARCHAR(50),
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50)
    );

    INSERT INTO #expected VALUES
    (
        @ProductID01, @ProductName01,
        @ProductID02, @ProductName02
    ),
    (
        @ProductID03, @ProductName03,
        @ProductID04, @ProductName04
    ),
    (
        @ProductID03, @ProductName03,
        @ProductID05, @ProductName05
    ),
    (
        @ProductID06, @ProductName06,
        @ProductID07, @ProductName07
    ),
    (
        @ProductID06, @ProductName06,
        @ProductID08, @ProductName08
    ),
    (
        @ProductID06, @ProductName06,
        @ProductID09, @ProductName09
    );

    -- Actual output.
    CREATE TABLE #actual (
        ParentProductID UNIQUEIDENTIFIER,
        ParentProductName NVARCHAR(50),
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableProductSet];

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
