
CREATE PROCEDURE [test_Constraints].[test_AK_EndUserRole_EndUserRoleName]
AS
BEGIN
    -- Create dummy data for EndUserRole.
    EXEC tSQLt.FakeTable '[dbo].[EndUserRole]';

    DECLARE @EndUserRoleName NVARCHAR(50) = 'End User Role Name 01';

    -- Apply unique (alternate key) constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[EndUserRole]', '[AK_EndUserRole_EndUserRoleName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[EndUserRole] (EndUserRoleName) VALUES
    (@EndUserRoleName),
    (@EndUserRoleName);
END;