
CREATE PROCEDURE [test_Views].[test_VI_ReadableAsset]
AS
BEGIN
    -- Create dummy data for Product.
    EXEC tSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ProductName01 NVARCHAR(50) = 'Product Name 01';
    DECLARE @ProductName02 NVARCHAR(50) = 'Product Name 02';

    INSERT INTO [dbo].[Product] (ProductID, ProductName) VALUES
    (@ProductID01, @ProductName01),
    (@ProductID02, @ProductName02);

    -- Create dummy data for Vendor.
    EXEC tSQLt.FakeTable '[dbo].[Vendor]';

    DECLARE @VendorID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @VendorID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @VendorName01 NVARCHAR(50) = 'Vendor Name 01';
    DECLARE @VendorName02 NVARCHAR(50) = 'Vendor Name 02';

    INSERT INTO [dbo].[Vendor] (VendorID, VendorName) VALUES
    (@VendorID01, @VendorName01),
    (@VendorID02, @VendorName02);

    -- Create dummy data for Location.
    EXEC tSQLt.FakeTable '[dbo].[Location]';

    DECLARE @LocationID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @LocationID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @LocationAddress01 NVARCHAR(50) = 'Location Address 01';
    DECLARE @LocationAddress02 NVARCHAR(50) = 'Location Address 02';

    INSERT INTO [dbo].[Location] (LocationID, LocationAddress) VALUES
    (@LocationID01, @LocationAddress01),
    (@LocationID02, @LocationAddress02);

    -- Create dummy data for Employee.
    EXEC tSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @EmployeeID01 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EmployeeFullName01 NVARCHAR(50) = 'Employee Full Name 01';

    INSERT INTO [dbo].[Employee] (EmployeeID, EmployeeFullName) VALUES
    (@EmployeeID01, @EmployeeFullName01);

    -- Create dummy data for Asset.
    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @AssetTagDate01 DATETIME = '2000-01-01';
    DECLARE @AssetTagDate02 DATETIME = '2000-01-02';

    DECLARE @AssetPurchaseDate01 DATETIME = '2000-01-01';
    DECLARE @AssetPurchaseDate02 DATETIME = '2000-01-02';

    DECLARE @AssetPurchasePrice01 MONEY = 1000;
    DECLARE @AssetPurchasePrice02 MONEY = 2000;

    DECLARE @AssetSerialNumber01 NVARCHAR(50) = '01';
    DECLARE @AssetSerialNumber02 NVARCHAR(50) = '02';

    DECLARE @AssetWarrantyUnitOfMeasure01 NCHAR(2) = 'yy';
    DECLARE @AssetWarrantyUnitOfMeasure02 NCHAR(2) = 'mm';

    DECLARE @AssetWarrantyDuration01 INT = 1;
    DECLARE @AssetWarrantyDuration02 INT = 2;

    DECLARE @AssetUsefulLife01 INT = 1;
    DECLARE @AssetUsefulLife02 INT = 2;

    DECLARE @AssetSalvageValue01 MONEY = 1000;
    DECLARE @AssetSalvageValue02 MONEY = 2000;

    INSERT INTO [dbo].[Asset] (
        AssetID,
        AssetTagDate,
        AssetPurchaseDate,
        AssetPurchasePrice,
        AssetSerialNumber,
        AssetWarrantyUnitOfMeasure,
        AssetWarrantyDuration,
        AssetUsefulLife,
        AssetSalvageValue,
        ProductID,
        VendorID,
        LocationID,
        EmployeeID
    ) VALUES
    (
        @AssetID01, @AssetTagDate01, @AssetPurchaseDate01, @AssetPurchasePrice01, @AssetSerialNumber01, @AssetWarrantyUnitOfMeasure01, @AssetWarrantyDuration01, @AssetUsefulLife01, @AssetSalvageValue01, @ProductID02, @VendorID02, @LocationID02, NULL
    ),(
        @AssetID02, @AssetTagDate02, @AssetPurchaseDate02, @AssetPurchasePrice02, @AssetSerialNumber02, @AssetWarrantyUnitOfMeasure02, @AssetWarrantyDuration02, @AssetUsefulLife02, @AssetSalvageValue02, @ProductID01, @VendorID01, @LocationID01, @EmployeeID01
    );

    -- Expected output.
    CREATE TABLE #expected (
        AssetID UNIQUEIDENTIFIER,
        AssetTagDate DATETIME,
        AssetPurchaseDate DATETIME,
        AssetPurchasePrice MONEY,
        AssetSerialNumber NVARCHAR(50),
        AssetWarrantyUnitOfMeasure NCHAR(2),
        AssetWarrantyDuration INT,
        AssetUsefulLife INT,
        AssetSalvageValue MONEY,
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        VendorID UNIQUEIDENTIFIER,
        VendorName NVARCHAR(50),
        LocationID UNIQUEIDENTIFIER,
        LocationAddress NVARCHAR(50),
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(50)
    );

    INSERT INTO #expected VALUES
    (
        @AssetID01, @AssetTagDate01, @AssetPurchaseDate01, @AssetPurchasePrice01, @AssetSerialNumber01, @AssetWarrantyUnitOfMeasure01, @AssetWarrantyDuration01, @AssetUsefulLife01, @AssetSalvageValue01, @ProductID02, @ProductName02, @VendorID02, @VendorName02, @LocationID02, @LocationAddress02, NULL, NULL
    ),(
        @AssetID02, @AssetTagDate02, @AssetPurchaseDate02, @AssetPurchasePrice02, @AssetSerialNumber02, @AssetWarrantyUnitOfMeasure02, @AssetWarrantyDuration02, @AssetUsefulLife02, @AssetSalvageValue02, @ProductID01, @ProductName01, @VendorID01, @VendorName01, @LocationID01, @LocationAddress01, @EmployeeID01, @EmployeeFullName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        AssetID UNIQUEIDENTIFIER,
        AssetTagDate DATETIME,
        AssetPurchaseDate DATETIME,
        AssetPurchasePrice MONEY,
        AssetSerialNumber NVARCHAR(50),
        AssetWarrantyUnitOfMeasure NCHAR(2),
        AssetWarrantyDuration INT,
        AssetUsefulLife INT,
        AssetSalvageValue MONEY,
        ProductID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        VendorID UNIQUEIDENTIFIER,
        VendorName NVARCHAR(50),
        LocationID UNIQUEIDENTIFIER,
        LocationAddress NVARCHAR(50),
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(50)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableAsset];

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;