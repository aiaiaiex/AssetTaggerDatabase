CREATE PROCEDURE [test_Constraints].[test_AK_Building_BuildingName]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC TSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingName NVARCHAR(50) = 'Building Name 1';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Building]', '[AK_Building_BuildingName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Building] (BuildingName) VALUES
    (@BuildingName),
    (@BuildingName);
END;
