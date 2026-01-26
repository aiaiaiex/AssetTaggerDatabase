
CREATE PROCEDURE [test_Constraints].[test_PK_Location]
AS
BEGIN
    -- Create dummy data for Location.
    EXEC tSQLt.FakeTable '[dbo].[Location]';

    DECLARE @LocationID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Location]', '[PK_Location]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Location] (LocationID) VALUES
    (@LocationID),
    (@LocationID);
END;