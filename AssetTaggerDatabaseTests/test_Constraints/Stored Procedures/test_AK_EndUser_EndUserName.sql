CREATE PROCEDURE [test_Constraints].[test_AK_EndUser_EndUserName]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';
    DECLARE @EndUserName NVARCHAR(50) = 'End User Name 1';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[EndUser]', '[AK_EndUser_EndUserName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[EndUser] (EndUserName) VALUES
    (@EndUserName),
    (@EndUserName);
END;
