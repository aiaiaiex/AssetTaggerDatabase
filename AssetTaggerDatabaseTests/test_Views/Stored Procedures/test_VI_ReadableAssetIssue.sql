CREATE PROCEDURE [test_Views].[test_VI_ReadableAssetIssue]
AS
BEGIN
    -- Create dummy data for Employee.
    EXEC TSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @EmployeeID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EmployeeFullName01 NVARCHAR(50) = 'Employee Full Name 01';
    DECLARE @EmployeeFullName02 NVARCHAR(50) = 'Employee Full Name 02';

    INSERT INTO [dbo].[Employee] (EmployeeID, EmployeeFullName) VALUES
    (@EmployeeID01, @EmployeeFullName01),
    (@EmployeeID02, @EmployeeFullName02);

    -- Create dummy data for Product.
    EXEC TSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ProductName01 NVARCHAR(50) = 'Product Name 01';
    DECLARE @ProductName02 NVARCHAR(50) = 'Product Name 02';

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

    DECLARE @AssetIssueTitle01 NVARCHAR(50) = 'Asset Issue Title 01';
    DECLARE @AssetIssueTitle02 NVARCHAR(50) = 'Asset Issue Title 02';

    DECLARE @AssetIssueDesc01 NVARCHAR(MAX) = 'Asset Issue Desc 01';
    DECLARE @AssetIssueDesc02 NVARCHAR(MAX) = 'Asset Issue Desc 02';

    DECLARE @AssetIssueDate01 DATETIME = '2000-01-01';
    DECLARE @AssetIssueDate02 DATETIME = '2000-01-02';

    INSERT INTO [dbo].[AssetIssue] (
        AssetIssueID,
        AssetIssueTitle,
        AssetIssueDesc,
        AssetIssueDate,
        AssetID,
        EmployeeID
    ) VALUES
    (
        @AssetIssueID01,
        @AssetIssueTitle01,
        @AssetIssueDesc01,
        @AssetIssueDate01,
        @AssetID02,
        @EmployeeID02
    ),
    (
        @AssetIssueID02,
        @AssetIssueTitle02,
        @AssetIssueDesc02,
        @AssetIssueDate02,
        @AssetID01,
        @EmployeeID01
    );

    -- Expected output.
    CREATE TABLE #expected (
        AssetIssueID UNIQUEIDENTIFIER,
        AssetIssueTitle NVARCHAR(50),
        AssetIssueDesc NVARCHAR(MAX),
        AssetIssueDate DATETIME,
        AssetID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(50)
    );

    INSERT INTO #expected VALUES
    (
        @AssetIssueID01,
        @AssetIssueTitle01,
        @AssetIssueDesc01,
        @AssetIssueDate01,
        @AssetID02,
        @ProductName02,
        @EmployeeID02,
        @EmployeeFullName02
    ),
    (
        @AssetIssueID02,
        @AssetIssueTitle02,
        @AssetIssueDesc02,
        @AssetIssueDate02,
        @AssetID01,
        @ProductName01,
        @EmployeeID01,
        @EmployeeFullName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        AssetIssueID UNIQUEIDENTIFIER,
        AssetIssueTitle NVARCHAR(50),
        AssetIssueDesc NVARCHAR(MAX),
        AssetIssueDate DATETIME,
        AssetID UNIQUEIDENTIFIER,
        ProductName NVARCHAR(50),
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(50)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableAssetIssue];

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
