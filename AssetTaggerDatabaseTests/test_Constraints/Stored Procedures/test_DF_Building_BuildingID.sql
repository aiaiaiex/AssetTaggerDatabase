
CREATE PROCEDURE [test_Constraints].[test_DF_Building_BuildingID]
AS
BEGIN
    -- Create dummy data for Building.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[Building]', @Defaults=1;

    DECLARE @BuildingName NVARCHAR(50) = 'eNtec 1';

    INSERT INTO [dbo].[Building] (BuildingName) VALUES
    (@BuildingName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = BuildingID from [dbo].[Building];

    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;