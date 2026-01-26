
CREATE PROCEDURE [test_Constraints].[test_PK_Category]
AS
BEGIN
    -- Create dummy data for Category.
    EXEC tSQLt.FakeTable '[dbo].[Category]';

    DECLARE @CategoryID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Category]', '[PK_Category]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Category] (CategoryID) VALUES
    (@CategoryID),
    (@CategoryID);
END;