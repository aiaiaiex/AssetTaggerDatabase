
CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetBuildingsOfSubsidiariesOfCompany]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC tSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID03 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID04 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Company] (CompanyID, ParentCompanyID) VALUES
    (@CompanyID01, NULL),
    (@CompanyID02, NULL),
    (@CompanyID03, @CompanyID01),
    (@CompanyID04, @CompanyID01);

    -- Create dummy data for Building.
    EXEC tSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID03 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID04 UNIQUEIDENTIFIER = NEWID();


    INSERT INTO [dbo].[Building] (BuildingID, CompanyID) VALUES
    (@BuildingID01, @CompanyID01),
    (@BuildingID02, @CompanyID02),
    (@BuildingID03, @CompanyID03),
    (@BuildingID04, @CompanyID04);

    -- Expected output.
    CREATE TABLE #expected (BuildingID UNIQUEIDENTIFIER);

    INSERT INTO #expected VALUES
    (@BuildingID03),
    (@BuildingID04);

    -- Actual output.
    CREATE TABLE #actual (BuildingID UNIQUEIDENTIFIER);

    INSERT INTO #actual (BuildingID)
    EXEC [dbo].[usp_GetBuildingsOfSubsidiariesOfCompany] @CompanyID01;

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;