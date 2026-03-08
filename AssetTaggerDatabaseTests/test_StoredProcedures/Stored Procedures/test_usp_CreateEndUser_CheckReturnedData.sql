
CREATE PROCEDURE [test_StoredProcedures].[test_usp_CreateEndUser_CheckReturnedData]
AS
BEGIN
    EXEC TSQLt.FakeTable '[dbo].[EndUser]', @Defaults = 1;

    DECLARE @EndUserName NVARCHAR(4000) = 'End User Name';
    DECLARE @EndUserPassword NVARCHAR(4000) = 'End User Password';
    DECLARE @EndUserRoleID UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID UNIQUEIDENTIFIER = NEWID();

    CREATE TABLE #actual (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(4000),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER
    );

    INSERT INTO #actual EXEC [dbo].[usp_CreateEndUser] @EndUserName, @EndUserPassword, @EndUserRoleID, @EmployeeID;

    DECLARE @EndUserID UNIQUEIDENTIFIER = (SELECT EndUserID FROM #actual);

    CREATE TABLE #expected (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(4000),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER,
    );

    INSERT INTO #expected (EndUserID, EndUserName, EndUserRoleID, EmployeeID)
    VALUES (
        @EndUserID,
        @EndUserName,
        @EndUserRoleID,
        @EmployeeID
    );

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;