CREATE PROCEDURE [test_Constraints].[test_AK_Manufacturer_ManufacturerName]
AS
BEGIN
    -- Create dummy data for Manufacturer.
    EXEC TSQLt.FakeTable '[dbo].[Manufacturer]';

    DECLARE @ManufacturerName NVARCHAR(50) = 'Manufacturer Name 01';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Manufacturer]', '[AK_Manufacturer_ManufacturerName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Manufacturer] (ManufacturerName) VALUES
    (@ManufacturerName),
    (@ManufacturerName);
END;
