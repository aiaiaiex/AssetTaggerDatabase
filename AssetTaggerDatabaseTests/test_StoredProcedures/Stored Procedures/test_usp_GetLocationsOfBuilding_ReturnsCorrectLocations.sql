CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetLocationsOfBuilding_ReturnsCorrectLocations]
AS
BEGIN

    EXEC tSQLt.FakeTable '[dbo].[Location]';

    DECLARE @TargetBuildingID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherBuildingID  UNIQUEIDENTIFIER = NEWID();

    DECLARE @Loc1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Loc2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseLoc UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Location] (LocationID, BuildingID)
    VALUES 
        (@Loc1, @TargetBuildingID),
        (@Loc2, @TargetBuildingID),
        (@NoiseLoc, @OtherBuildingID);

    CREATE TABLE #actual (LocationID UNIQUEIDENTIFIER);

    INSERT INTO #actual (LocationID)
    EXEC [dbo].[usp_GetLocationsOfBuilding] @BuildingID = @TargetBuildingID;

    CREATE TABLE #expected (LocationID UNIQUEIDENTIFIER);
    INSERT INTO #expected (LocationID) VALUES (@Loc1), (@Loc2);

    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;