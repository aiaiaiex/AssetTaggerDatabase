CREATE PROCEDURE [test_Constraints].[test_AK_Building_BuildingAddress]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC TSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingAddress NVARCHAR(4000) = 'Building Address 01';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Building]', '[AK_Building_BuildingAddress]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Building] (BuildingAddress) VALUES
    (@BuildingAddress),
    (@BuildingAddress);
END;
