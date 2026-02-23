
CREATE PROCEDURE [test_StoredProcedures].[test_usp_UpdateEndUser]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @EndUserID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EndUserName01 NVARCHAR(50) = 'End User Name 01';
    DECLARE @EndUserName02 NVARCHAR(50) = 'End User Name 02';
    DECLARE @EndUserName01B NVARCHAR(50) = 'End User Name 01B';

    DECLARE @EndUserRoleID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserRoleID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserRoleID01B UNIQUEIDENTIFIER = NEWID();

    DECLARE @EmployeeID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID01B UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[EndUser] (EndUserID, EndUserName, EndUserRoleID, EmployeeID) VALUES
    (@EndUserID01, @EndUserName01, @EndUserRoleID01, @EmployeeID01),
    (@EndUserID02, @EndUserName02, @EndUserRoleID02, @EmployeeID02);

    -- Actual output.
    CREATE TABLE #actual (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(50),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER,
        OldEndUserName NVARCHAR(50),
        OldEndUserRoleID UNIQUEIDENTIFIER,
        OldEmployeeID UNIQUEIDENTIFIER,
    );

    INSERT INTO #actual EXEC [dbo].[usp_UpdateEndUser]
        @EndUserID = @EndUserID01,
        @EndUserName = @EndUserName01B,
        @EndUserRoleID = @EndUserRoleID01B,
        @EmployeeID = @EmployeeID01B,
        @NullifyEndUserRoleID = 0,
        @NullifyEmployeeID = 0;

    -- Expected output.
    CREATE TABLE #expected (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(50),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER,
        OldEndUserName NVARCHAR(50),
        OldEndUserRoleID UNIQUEIDENTIFIER,
        OldEmployeeID UNIQUEIDENTIFIER,
    );

    INSERT INTO #expected (
        EndUserID,
        EndUserName,
        EndUserRoleID,
        EmployeeID,
        OldEndUserName,
        OldEndUserRoleID,
        OldEmployeeID
    )
    VALUES (
        @EndUserID01,
        @EndUserName01B,
        @EndUserRoleID01B,
        @EmployeeID01B,
        @EndUserName01,
        @EndUserRoleID01,
        @EmployeeID01
    );

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;