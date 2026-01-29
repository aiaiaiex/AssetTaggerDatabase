CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetAssetsByEmployee_ReturnsOnlyAssignedAssets]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @TargetEmployeeID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherEmployeeID UNIQUEIDENTIFIER = NEWID();

    DECLARE @Asset1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Asset2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Asset3 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Asset] (AssetID, EmployeeID)
    VALUES
    (@Asset1, @TargetEmployeeID),
    (@Asset2, @TargetEmployeeID),
    (@Asset3, @OtherEmployeeID);

    CREATE TABLE #actual (AssetID UNIQUEIDENTIFIER);

    INSERT INTO #actual (AssetID)
    EXEC [dbo].[usp_GetAssetsByEmployee] @EmployeeID = @TargetEmployeeID;

    CREATE TABLE #expected (AssetID UNIQUEIDENTIFIER);
    INSERT INTO #expected (AssetID) VALUES (@Asset1), (@Asset2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
