CREATE PROCEDURE [test_Constraints].[test_DF_Manufacturer_ManufacturerID]
AS
BEGIN
    -- Create dummy data for Manufacturer.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Manufacturer]', @Defaults = 1;

    DECLARE @ManufacturerName NVARCHAR(50) = 'Manufacturer Name 01';

    INSERT INTO [dbo].[Manufacturer] (ManufacturerName) VALUES
    (@ManufacturerName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = ManufacturerID FROM [dbo].[Manufacturer];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
