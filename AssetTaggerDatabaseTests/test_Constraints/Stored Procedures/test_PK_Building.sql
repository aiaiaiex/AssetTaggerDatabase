
CREATE PROCEDURE [test_Constraints].[test_PK_Building]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC tSQLt.FakeTable '[dbo].[Building]';

    DECLARE @BuildingID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Building]', '[PK_Building]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Building] (BuildingID) VALUES
    (@BuildingID),
    (@BuildingID);
END;