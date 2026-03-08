
CREATE PROCEDURE [test_StoredProcedures].[test_usp_CreateEndUser_CheckInsertedRow]
AS
BEGIN
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @EndUserName NVARCHAR(4000) = 'End User Name';
    DECLARE @EndUserPassword NVARCHAR(4000) = 'End User Password';
    DECLARE @EndUserRoleID UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID UNIQUEIDENTIFIER = NEWID();

    -- Create #output table to insert the returned data of the executed stored procedure to NOT print its results.
    CREATE TABLE #output (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(4000),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER
    );
    INSERT INTO #output EXEC [dbo].[usp_CreateEndUser] @EndUserName, @EndUserPassword, @EndUserRoleID, @EmployeeID;

    CREATE TABLE #expected (
        EndUserName NVARCHAR(4000),
        EndUserPasswordHash NCHAR(32),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER
    );

    INSERT INTO #expected (EndUserName, EndUserPasswordHash, EndUserRoleID, EmployeeID)
    VALUES (
        @EndUserName,
        CONVERT(NCHAR(32), HASHBYTES('SHA2_256', @EndUserPassword)),
        @EndUserRoleID,
        @EmployeeID
    );

    SELECT
        EndUserName,
        EndUserPasswordHash,
        EndUserRoleID,
        EmployeeID
    INTO #actual
    FROM [dbo].[EndUser];

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;