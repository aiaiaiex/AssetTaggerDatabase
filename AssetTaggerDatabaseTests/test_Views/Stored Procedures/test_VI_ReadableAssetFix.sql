CREATE PROCEDURE [test_Views].[test_VI_ReadableAssetFix]
AS
BEGIN
    -- Create dummy data for Employee.
    EXEC TSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @EmployeeID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EmployeeFullName01 NVARCHAR(4000) = 'Employee Full Name 01';
    DECLARE @EmployeeFullName02 NVARCHAR(4000) = 'Employee Full Name 02';

    INSERT INTO [dbo].[Employee] (EmployeeID, EmployeeFullName) VALUES
    (@EmployeeID01, @EmployeeFullName01),
    (@EmployeeID02, @EmployeeFullName02);

    -- Create dummy data for Product.
    EXEC TSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ProductName01 NVARCHAR(4000) = 'Product Name 01';
    DECLARE @ProductName02 NVARCHAR(4000) = 'Product Name 02';

    INSERT INTO [dbo].[Product] (ProductID, ProductName) VALUES
    (@ProductID01, @ProductName01),
    (@ProductID02, @ProductName02);

    -- Create dummy data for Asset.
    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID02 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Asset] (AssetID, ProductID) VALUES
    (@AssetID01, @ProductID01),
    (@AssetID02, @ProductID02);

    -- Create dummy data for AssetIssue.
    EXEC TSQLt.FakeTable '[dbo].[AssetIssue]';

    DECLARE @AssetIssueID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetIssueID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @AssetIssueTitle01 NVARCHAR(4000) = 'Asset Issue Title 01';
    DECLARE @AssetIssueTitle02 NVARCHAR(4000) = 'Asset Issue Title 02';

    INSERT INTO [dbo].[AssetIssue] (AssetIssueID, AssetIssueTitle, AssetID) VALUES
    (@AssetIssueID01, @AssetIssueTitle01, @AssetID01),
    (@AssetIssueID02, @AssetIssueTitle02, @AssetID02);

    -- Create dummy data for AssetFix.
    EXEC TSQLt.FakeTable '[dbo].[AssetFix]';

    DECLARE @AssetFixID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetFixID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @AssetFixDateStart01 DATETIME = '2000-01-01';
    DECLARE @AssetFixDateStart02 DATETIME = '2000-01-02';

    DECLARE @AssetFixCost01 MONEY = 1000;
    DECLARE @AssetFixCost02 MONEY = 2000;

    DECLARE @AssetFixDateEnd01 DATETIME = '2000-01-01';
    DECLARE @AssetFixDateEnd02 DATETIME = '2000-01-02';

    DECLARE @AssetFixTitle01 NVARCHAR(4000) = 'Asset Fix Title 01';
    DECLARE @AssetFixTitle02 NVARCHAR(4000) = 'Asset Fix Title 02';

    DECLARE @AssetFixDescription01 NVARCHAR(MAX) = 'Asset Fix Description 01';
    DECLARE @AssetFixDescription02 NVARCHAR(MAX) = 'Asset Fix Description 02';

    DECLARE @AssetFixed01 BIT = 0;
    DECLARE @AssetFixed02 BIT = 1;

    INSERT INTO [dbo].[AssetFix] (
        AssetFixID,
        AssetIssueID,
        AssetFixDateStart,
        AssetFixCost,
        AssetFixDateEnd,
        AssetFixTitle,
        AssetFixDescription,
        AssetFixed,
        EmployeeID
    ) VALUES
    (
        @AssetFixID01,
        @AssetIssueID02,
        @AssetFixDateStart01,
        @AssetFixCost01,
        @AssetFixDateEnd01,
        @AssetFixTitle01,
        @AssetFixDescription01,
        @AssetFixed01,
        @EmployeeID02
    ),
    (
        @AssetFixID02,
        @AssetIssueID01,
        @AssetFixDateStart02,
        @AssetFixCost02,
        @AssetFixDateEnd02,
        @AssetFixTitle02,
        @AssetFixDescription02,
        @AssetFixed02,
        @EmployeeID01
    );

    -- Expected output.
    CREATE TABLE #expected (
        AssetFixID UNIQUEIDENTIFIER,
        AssetIssueID UNIQUEIDENTIFIER,
        AssetIssueTitle NVARCHAR(4000),
        ProductName NVARCHAR(4000),
        AssetFixDateStart DATETIME,
        AssetFixCost MONEY,
        AssetFixDateEnd DATETIME,
        AssetFixTitle NVARCHAR(4000),
        AssetFixDescription NVARCHAR(MAX),
        AssetFixed BIT,
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(4000)
    );

    INSERT INTO #expected VALUES
    (
        @AssetFixID01,
        @AssetIssueID02,
        @AssetIssueTitle02,
        @ProductName02,
        @AssetFixDateStart01,
        @AssetFixCost01,
        @AssetFixDateEnd01,
        @AssetFixTitle01,
        @AssetFixDescription01,
        @AssetFixed01,
        @EmployeeID02,
        @EmployeeFullName02
    ),
    (
        @AssetFixID02,
        @AssetIssueID01,
        @AssetIssueTitle01,
        @ProductName01,
        @AssetFixDateStart02,
        @AssetFixCost02,
        @AssetFixDateEnd02,
        @AssetFixTitle02,
        @AssetFixDescription02,
        @AssetFixed02,
        @EmployeeID01,
        @EmployeeFullName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        AssetFixID UNIQUEIDENTIFIER,
        AssetIssueID UNIQUEIDENTIFIER,
        AssetIssueTitle NVARCHAR(4000),
        ProductName NVARCHAR(4000),
        AssetFixDateStart DATETIME,
        AssetFixCost MONEY,
        AssetFixDateEnd DATETIME,
        AssetFixTitle NVARCHAR(4000),
        AssetFixDescription NVARCHAR(MAX),
        AssetFixed BIT,
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(4000)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableAssetFix];

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
