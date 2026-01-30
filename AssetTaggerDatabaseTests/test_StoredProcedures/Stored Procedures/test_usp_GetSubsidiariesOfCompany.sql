CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetSubsidiariesOfCompany]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID03 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID04 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID05 UNIQUEIDENTIFIER = NEWID();

    DECLARE @ParentCompanyID01 UNIQUEIDENTIFIER = NULL;
    DECLARE @ParentCompanyID02 UNIQUEIDENTIFIER = @CompanyID01;
    DECLARE @ParentCompanyID03 UNIQUEIDENTIFIER = @CompanyID02;
    DECLARE @ParentCompanyID04 UNIQUEIDENTIFIER = NULL;
    DECLARE @ParentCompanyID05 UNIQUEIDENTIFIER = @CompanyID01;

    INSERT INTO [dbo].[Company] (CompanyID, ParentCompanyID) VALUES
    (@CompanyID01, @ParentCompanyID01),
    (@CompanyID02, @ParentCompanyID02),
    (@CompanyID03, @ParentCompanyID03),
    (@CompanyID04, @ParentCompanyID04),
    (@CompanyID05, @ParentCompanyID05);

    -- Expected output.
    CREATE TABLE #expected (CompanyID UNIQUEIDENTIFIER);

    INSERT INTO #expected VALUES
    (@CompanyID02),
    (@CompanyID05);

    -- Actual output.
    CREATE TABLE #actual (CompanyID UNIQUEIDENTIFIER);

    INSERT INTO #actual (CompanyID)
    EXEC [dbo].[usp_GetSubsidiariesOfCompany] @CompanyID01;

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
