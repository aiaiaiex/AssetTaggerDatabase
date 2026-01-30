CREATE PROCEDURE [test_Constraints].[test_PK_Role]
AS
BEGIN
    -- Create dummy data for Role.
    EXEC TSQLt.FakeTable '[dbo].[Role]';

    DECLARE @RoleID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Role]', '[PK_Role]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Role] (RoleID) VALUES
    (@RoleID),
    (@RoleID);
END;
