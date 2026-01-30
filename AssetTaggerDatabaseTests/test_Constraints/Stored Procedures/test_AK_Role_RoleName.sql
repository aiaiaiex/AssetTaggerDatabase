CREATE PROCEDURE [test_Constraints].[test_AK_Role_RoleName]
AS
BEGIN
    -- Create dummy data for Role.
    EXEC TSQLt.FakeTable '[dbo].[Role]';
    DECLARE @RoleName NVARCHAR(50) = 'Role Name 1';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Role]', '[AK_Role_RoleName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Role] (RoleName) VALUES
    (@RoleName),
    (@RoleName);
END;
