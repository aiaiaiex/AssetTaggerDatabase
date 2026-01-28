
CREATE PROCEDURE [test_Constraints].[test_PK_Manufacturer]
AS
BEGIN
    -- Create dummy data for Manufacturer.
    EXEC tSQLt.FakeTable '[dbo].[Manufacturer]';

    DECLARE @ManufacturerID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Manufacturer]', '[PK_Manufacturer]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Manufacturer] (ManufacturerID) VALUES
    (@ManufacturerID),
    (@ManufacturerID);
END;