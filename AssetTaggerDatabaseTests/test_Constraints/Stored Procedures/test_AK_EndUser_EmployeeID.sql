
CREATE PROCEDURE [test_Constraints].[test_AK_EndUser_EmployeeID]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @EmployeeID UNIQUEIDENTIFIER = NEWID();

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[EndUser]', '[AK_EndUser_EmployeeID]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[EndUser] (EmployeeID) VALUES
    (@EmployeeID),
    (@EmployeeID);
END;