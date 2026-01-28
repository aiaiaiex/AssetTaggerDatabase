
CREATE PROCEDURE [test_Constraints].[test_DF_EndUserRole_EndUserRoleID]
AS
BEGIN
    -- Create dummy data for EndUserRole.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[EndUserRole]', @Defaults=1;

    DECLARE @EndUserRoleName NVARCHAR(50) = 'End User Role Name 01';

    INSERT INTO [dbo].[EndUserRole] (EndUserRoleName) VALUES
    (@EndUserRoleName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = EndUserRoleID from [dbo].[EndUserRole];

    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;