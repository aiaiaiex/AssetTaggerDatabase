CREATE PROCEDURE [test_StoredProcedures].[test_usp_ReadEndUser_WithGetOnlyNonNullEndUserRoleID]
AS
BEGIN
    -- Create dummy data for EndUser.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @EndUserID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserID03 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EndUserName01 NVARCHAR(50) = 'End User Name 01';
    DECLARE @EndUserName02 NVARCHAR(50) = 'End User Name 02';
    DECLARE @EndUserName03 NVARCHAR(50) = 'End User Name 03';

    DECLARE @EndUserRoleID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserRoleID02 UNIQUEIDENTIFIER = NULL;
    DECLARE @EndUserRoleID03 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EmployeeID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID03 UNIQUEIDENTIFIER = NULL;

    INSERT INTO [dbo].[EndUser] (EndUserID, EndUserName, EndUserRoleID, EmployeeID) VALUES
    (@EndUserID01, @EndUserName01, @EndUserRoleID01, @EmployeeID01),
    (@EndUserID02, @EndUserName02, @EndUserRoleID02, @EmployeeID02),
    (@EndUserID03, @EndUserName03, @EndUserRoleID03, @EmployeeID03);

    -- Actual output.
    CREATE TABLE #actual (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(50),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER,
    );

    INSERT INTO #actual EXEC [dbo].[usp_ReadEndUser]
        @GetOnlyNonNullEndUserRoleID = 1;

    -- Expected output.
    CREATE TABLE #expected (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(50),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER,
    );

    INSERT INTO #expected (EndUserID, EndUserName, EndUserRoleID, EmployeeID) VALUES
    (@EndUserID01, @EndUserName01, @EndUserRoleID01, @EmployeeID01),
    (@EndUserID03, @EndUserName03, @EndUserRoleID03, @EmployeeID03);

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
