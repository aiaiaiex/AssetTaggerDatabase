
CREATE PROCEDURE [test_Constraints].[test_FK_Location_Building]
AS
BEGIN
    -- Create dummy data for Location.
    EXEC tSQLt.FakeTable '[dbo].[Location]';
    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Location]', '[FK_Location_Building]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Location] (BuildingID) VALUES
    (NEWID());
END;