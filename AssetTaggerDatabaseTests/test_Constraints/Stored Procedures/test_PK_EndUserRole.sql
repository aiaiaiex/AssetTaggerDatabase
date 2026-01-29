CREATE PROCEDURE [test_Constraints].[test_PK_EndUserRole]
AS
BEGIN
    -- Create dummy data for EndUserRole.
    EXEC TSQLt.FakeTable '[dbo].[EndUserRole]';

    DECLARE @EndUserRoleID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[EndUserRole]', '[PK_EndUserRole]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[EndUserRole] (EndUserRoleID) VALUES
    (@EndUserRoleID),
    (@EndUserRoleID);
END;
