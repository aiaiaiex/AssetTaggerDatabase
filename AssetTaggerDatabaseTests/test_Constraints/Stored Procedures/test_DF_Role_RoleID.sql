CREATE PROCEDURE [test_Constraints].[test_DF_Role_RoleID]
AS
BEGIN
    -- Create dummy data for Role.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Role]', @Defaults = 1;

    DECLARE @RoleName NVARCHAR(50) = 'Role Name 01';

    INSERT INTO [dbo].[Role] (RoleName) VALUES
    (@RoleName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = RoleID FROM [dbo].[Role];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
