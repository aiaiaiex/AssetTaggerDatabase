CREATE PROCEDURE [test_Constraints].[test_DF_Location_LocationID]
AS
BEGIN
    -- Create dummy data for Location.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Location]', @Defaults = 1;

    DECLARE @LocationAddress NVARCHAR(4000) = 'Location Address 01';

    INSERT INTO [dbo].[Location] (LocationAddress) VALUES
    (@LocationAddress);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = LocationID FROM [dbo].[Location];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
