
CREATE PROCEDURE [test_Views].[test_VI_ReadableLocation]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC tSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @BuildingID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @BuildingName01 NVARCHAR(50) = 'Building Name 01';
    DECLARE @BuildingName02 NVARCHAR(50) = 'Building Name 02';

    INSERT INTO [dbo].[Building] (
        BuildingID,
        BuildingName
    ) VALUES
    (
        @BuildingID01,
        @BuildingName01
    ),
    (
        @BuildingID02,
        @BuildingName02
    );

    -- Create dummy data for Location.
    EXEC tSQLt.FakeTable '[dbo].[Location]';

    DECLARE @LocationID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @LocationID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @LocationAddress01 NVARCHAR(50) = 'Location Address 01';
    DECLARE @LocationAddress02 NVARCHAR(50) = 'Location Address 02';

    INSERT INTO [dbo].[Location] (
        LocationID,
        LocationAddress,
        BuildingID
    ) VALUES
    (
        @LocationID01,
        @LocationAddress01,
        @BuildingID02
    ),
    (
        @LocationID02,
        @LocationAddress02,
        @BuildingID01
    );

    -- Expected output.
    CREATE TABLE #expected (
        LocationID UNIQUEIDENTIFIER,
        LocationAddress NVARCHAR(50),
        BuildingID UNIQUEIDENTIFIER,
        BuildingName NVARCHAR(50) 
    );

    INSERT INTO #expected VALUES
    (
        @LocationID01,
        @LocationAddress01,
        @BuildingID02,
        @BuildingName02
    ),
    (
        @LocationID02,
        @LocationAddress02,
        @BuildingID01,
        @BuildingName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        LocationID UNIQUEIDENTIFIER,
        LocationAddress NVARCHAR(50),
        BuildingID UNIQUEIDENTIFIER,
        BuildingName NVARCHAR(50) 
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableLocation];

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;