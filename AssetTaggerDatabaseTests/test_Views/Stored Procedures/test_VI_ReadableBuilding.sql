CREATE PROCEDURE [test_Views].[test_VI_ReadableBuilding]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CompanyName01 NVARCHAR(50) = 'Company Name 01';
    DECLARE @CompanyName02 NVARCHAR(50) = 'Company Name 02';

    INSERT INTO [dbo].[Company] (CompanyID, CompanyName) VALUES
    (@CompanyID01, @CompanyName01),
    (@CompanyID02, @CompanyName02);

    -- Create dummy data for Building.
    EXEC TSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @BuildingName01 NVARCHAR(50) = 'Building Name 01';
    DECLARE @BuildingName02 NVARCHAR(50) = 'Building Name 02';

    DECLARE @BuildingAddress01 NVARCHAR(50) = 'Building Address 01';
    DECLARE @BuildingAddress02 NVARCHAR(50) = 'Building Address 02';

    INSERT INTO [dbo].[Building] (
        BuildingID,
        BuildingName,
        CompanyID,
        BuildingAddress
    ) VALUES
    (
        @BuildingID01,
        @BuildingName01,
        @CompanyID02,
        @BuildingAddress01
    ),
    (
        @BuildingID02,
        @BuildingName02,
        @CompanyID01,
        @BuildingAddress02
    );

    -- Expected output.
    CREATE TABLE #expected (
        BuildingID UNIQUEIDENTIFIER,
        BuildingName NVARCHAR(50),
        BuildingAddress NVARCHAR(50),
        CompanyID UNIQUEIDENTIFIER,
        CompanyName NVARCHAR(50)
    );

    INSERT INTO #expected VALUES
    (
        @BuildingID01,
        @BuildingName01,
        @BuildingAddress01,
        @CompanyID02,
        @CompanyName02
    ),
    (
        @BuildingID02,
        @BuildingName02,
        @BuildingAddress02,
        @CompanyID01,
        @CompanyName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        BuildingID UNIQUEIDENTIFIER,
        BuildingName NVARCHAR(50),
        BuildingAddress NVARCHAR(50),
        CompanyID UNIQUEIDENTIFIER,
        CompanyName NVARCHAR(50)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableBuilding];

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
