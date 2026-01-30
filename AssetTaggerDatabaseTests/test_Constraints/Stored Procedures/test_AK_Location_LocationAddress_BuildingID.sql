CREATE PROCEDURE [test_Constraints].[test_AK_Location_LocationAddress_BuildingID]
AS
BEGIN
    -- Create dummy data for Location.
    EXEC TSQLt.FakeTable '[dbo].[Location]';

    DECLARE @LocationAddress NVARCHAR(50) = 'Location Address 01';
    DECLARE @BuildingID UNIQUEIDENTIFIER = NEWID();

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Location]', '[AK_Location_LocationAddress_BuildingID]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Location] (LocationAddress, BuildingID) VALUES
    (@LocationAddress, @BuildingID),
    (@LocationAddress, @BuildingID);
END;
