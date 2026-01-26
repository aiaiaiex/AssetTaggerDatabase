
CREATE PROCEDURE [test_Constraints].[test_PK_Role]
AS
BEGIN
    -- Create dummy data for Role.
    EXEC tSQLt.FakeTable '[dbo].[Role]';

    DECLARE @RoleID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Role]', '[PK_Role]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Role] (RoleID) VALUES
    (@RoleID),
    (@RoleID);
END;