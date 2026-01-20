
CREATE PROCEDURE [test_Views].[test_VI_ReadableAssetTransfer]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC tSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CompanyName01 NVARCHAR(50) = 'Company Name 01';
    DECLARE @CompanyName02 NVARCHAR(50) = 'Company Name 02';

    INSERT INTO [dbo].[Company] (CompanyID, CompanyName) VALUES
    (@CompanyID01, @CompanyName01),
    (@CompanyID02, @CompanyName02);

    -- Create dummy data for Product.
    EXEC tSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ProductName01 NVARCHAR(50) = 'Product Name 01';
    DECLARE @ProductName02 NVARCHAR(50) = 'Product Name 02';

    INSERT INTO [dbo].[Product] (ProductID, ProductName) VALUES
    (@ProductID01, @ProductName01),
    (@ProductID02, @ProductName02);

    -- Create dummy data for Asset.
    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID02 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Asset] (AssetID, ProductID) VALUES
    (@AssetID01, @ProductID01),
    (@AssetID02, @ProductID02);

    -- Create dummy data for AssetTransfer.
    EXEC tSQLt.FakeTable '[dbo].[AssetTransfer]';

    DECLARE @AssetTransferID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetTransferID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @AssetTransferDate01 DATETIME = '2000-01-01';
    DECLARE @AssetTransferDate02 DATETIME = '2000-01-02';

    DECLARE @AssetTransferPrice01 MONEY = 1000;
    DECLARE @AssetTransferPrice02 MONEY = 2000;

    INSERT INTO [dbo].[AssetTransfer] (
        AssetTransferID,
        AssetTransferDate,
        AssetTransferPrice,
        AssetID,
        CompanyID,
        ReceivingCompanyID
    ) VALUES
    (
        @AssetTransferID01,
        @AssetTransferDate01,
        @AssetTransferPrice01,
        @AssetID02,
        @CompanyID02,
        @CompanyID01
    ),(
        @AssetTransferID02,
        @AssetTransferDate02,
        @AssetTransferPrice02,
        @AssetID01,
        @CompanyID01,
        @CompanyID02
    );

    -- Expected output.
    CREATE TABLE #expected (
        AssetTransferID UNIQUEIDENTIFIER,
        AssetTransferDate DATETIME,
        AssetTransferPrice MONEY,
        AssetID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        CompanyID UNIQUEIDENTIFIER,
        CompanyName NVARCHAR(50),
        ReceivingCompanyID UNIQUEIDENTIFIER,
        ReceivingCompanyName NVARCHAR(50)
    );

    INSERT INTO #expected VALUES
    (
        @AssetTransferID01,
        @AssetTransferDate01,
        @AssetTransferPrice01,
        @AssetID02,
        @ProductName02,
        @CompanyID02,
        @CompanyName02,
        @CompanyID01,
        @CompanyName01
    ),
    (
        @AssetTransferID02,
        @AssetTransferDate02,
        @AssetTransferPrice02,
        @AssetID01,
        @ProductName01,
        @CompanyID01,
        @CompanyName01,
        @CompanyID02,
        @CompanyName02
    );

    -- Actual output.
    CREATE TABLE #actual (
        AssetTransferID UNIQUEIDENTIFIER,
        AssetTransferDate DATETIME,
        AssetTransferPrice MONEY,
        AssetID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        CompanyID UNIQUEIDENTIFIER,
        CompanyName NVARCHAR(50),
        ReceivingCompanyID UNIQUEIDENTIFIER,
        ReceivingCompanyName NVARCHAR(50)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableAssetTransfer];

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;