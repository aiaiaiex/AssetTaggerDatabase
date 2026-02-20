
CREATE PROCEDURE [test_Constraints].[test_CK_EndUser_EndUserName_MinimumLength]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    -- Apply check constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[EndUser]', '[CK_EndUser_EndUserName_MinimumLength]';

    -- Test check constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting unacceptable data.
    INSERT INTO [dbo].[EndUser] (EndUserName) VALUES ('');
END;