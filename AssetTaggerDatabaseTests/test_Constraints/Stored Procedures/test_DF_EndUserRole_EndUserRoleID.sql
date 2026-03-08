CREATE PROCEDURE [test_Constraints].[test_DF_EndUserRole_EndUserRoleID]
AS
BEGIN
    -- Create dummy data for EndUserRole.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[EndUserRole]', @Defaults = 1;

    DECLARE @EndUserRoleName NVARCHAR(4000) = 'End User Role Name 01';

    INSERT INTO [dbo].[EndUserRole] (EndUserRoleName) VALUES
    (@EndUserRoleName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = EndUserRoleID FROM [dbo].[EndUserRole];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
