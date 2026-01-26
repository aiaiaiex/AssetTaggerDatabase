
CREATE PROCEDURE [test_Constraints].[test_AK_Building_BuildingAddress]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC tSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingAddress NVARCHAR(50) = 'Building Address 01';

    -- Apply unique (alternate key) constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Building]', '[AK_Building_BuildingAddress]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Building] (BuildingAddress) VALUES
    (@BuildingAddress),
    (@BuildingAddress);
END;