
CREATE PROCEDURE [test_Views].[test_VI_ReadableCompany]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC tSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CompanyName01 NVARCHAR(50) = 'Company Name 01';
    DECLARE @CompanyName02 NVARCHAR(50) = 'Company Name 02';

    DECLARE @CompanyAddress01 NVARCHAR(50) = 'Company Address 01';
    DECLARE @CompanyAddress02 NVARCHAR(50) = 'Company Address 02';

    DECLARE @CompanyCode01 NVARCHAR(5) = 'Code1';
    DECLARE @CompanyCode02 NVARCHAR(5) = 'Code2';

    INSERT INTO [dbo].[Company] (
        CompanyID,
        ParentCompanyID,
        CompanyName,
        CompanyAddress,
        CompanyCode
    ) VALUES
    (
        @CompanyID01,
        NULL,
        @CompanyName01,
        @CompanyAddress01,
        @CompanyCode01
    ),
    (
        @CompanyID02,
        @CompanyID01,
        @CompanyName02,
        @CompanyAddress02,
        @CompanyCode02
    );

    -- Expected output.
    CREATE TABLE #expected (
        CompanyID UNIQUEIDENTIFIER,
        ParentCompanyID UNIQUEIDENTIFIER,
        ParentCompanyName NVARCHAR(50),
        CompanyName NVARCHAR(50),
        CompanyAddress NVARCHAR(50),
        CompanyCode NVARCHAR(5)
    );

    INSERT INTO #expected VALUES
    (
        @CompanyID01,
        NULL,
        NULL,
        @CompanyName01,
        @CompanyAddress01,
        @CompanyCode01
    ),
    (
        @CompanyID02,
        @CompanyID01,
        @CompanyName01,
        @CompanyName02,
        @CompanyAddress02,
        @CompanyCode02
    );

    -- Actual output.
    CREATE TABLE #actual (
        CompanyID UNIQUEIDENTIFIER,
        ParentCompanyID UNIQUEIDENTIFIER,
        ParentCompanyName NVARCHAR(50),
        CompanyName NVARCHAR(50),
        CompanyAddress NVARCHAR(50),
        CompanyCode NVARCHAR(5)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableCompany];

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;