
CREATE PROCEDURE [test_Constraints].[test_PK_EndUser]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC tSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @EndUserID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[EndUser]', '[PK_EndUser]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[EndUser] (EndUserID) VALUES
    (@EndUserID),
    (@EndUserID);
END;