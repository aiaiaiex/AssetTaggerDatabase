CREATE PROCEDURE [test_Constraints].[test_DF_Building_BuildingID]
AS
BEGIN
    -- Create dummy data for Building.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Building]', @Defaults = 1;

    DECLARE @BuildingName NVARCHAR(4000) = 'eNtec 1';

    INSERT INTO [dbo].[Building] (BuildingName) VALUES
    (@BuildingName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = BuildingID FROM [dbo].[Building];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
