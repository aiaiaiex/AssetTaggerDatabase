CREATE PROCEDURE [test_Constraints].[test_AK_EndUserRole_EndUserRoleName]
AS
BEGIN
    -- Create dummy data for EndUserRole.
    EXEC TSQLt.FakeTable '[dbo].[EndUserRole]';

    DECLARE @EndUserRoleName NVARCHAR(50) = 'End User Role Name 01';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[EndUserRole]', '[AK_EndUserRole_EndUserRoleName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[EndUserRole] (EndUserRoleName) VALUES
    (@EndUserRoleName),
    (@EndUserRoleName);
END;
