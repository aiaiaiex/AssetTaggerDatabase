
CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetBuildingsOfCompany]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC tSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID03 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID04 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID05 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID03 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Building] (BuildingID, CompanyID) VALUES
    (@BuildingID01, @CompanyID01),
    (@BuildingID02, @CompanyID02),
    (@BuildingID03, @CompanyID02),
    (@BuildingID04, @CompanyID01),
    (@BuildingID05, @CompanyID03);

    -- Expected output.
    CREATE TABLE #expected (BuildingID UNIQUEIDENTIFIER);

    INSERT INTO #expected VALUES
    (@BuildingID01),
    (@BuildingID04);

    -- Actual output.
    CREATE TABLE #actual (BuildingID UNIQUEIDENTIFIER);

    INSERT INTO #actual (BuildingID)
    EXEC [dbo].[usp_GetBuildingsOfCompany] @CompanyID01;

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;