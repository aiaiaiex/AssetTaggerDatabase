CREATE PROCEDURE [test_StoredProcedures].[test_usp_DeleteEndUser]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @EndUserID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EndUserName01 NVARCHAR(4000) = 'End User Name 01';
    DECLARE @EndUserName02 NVARCHAR(4000) = 'End User Name 02';

    DECLARE @EndUserRoleID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserRoleID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EmployeeID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID02 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[EndUser] (EndUserID, EndUserName, EndUserRoleID, EmployeeID) VALUES
    (@EndUserID01, @EndUserName01, @EndUserRoleID01, @EmployeeID01),
    (@EndUserID02, @EndUserName02, @EndUserRoleID02, @EmployeeID02);

    -- Actual output.
    CREATE TABLE #actual (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(4000),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER
    );

    INSERT INTO #actual EXEC [dbo].[usp_DeleteEndUser] @EndUserID01;

    -- Expected output.
    CREATE TABLE #expected (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(4000),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER,
    );

    INSERT INTO #expected (EndUserID, EndUserName, EndUserRoleID, EmployeeID)
    VALUES (
        @EndUserID01,
        @EndUserName01,
        @EndUserRoleID01,
        @EmployeeID01
    );

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
