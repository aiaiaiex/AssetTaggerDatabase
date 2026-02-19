
CREATE PROCEDURE [test_StoredProcedures].[test_usp_CreateEndUser_CheckInsertedRow]
AS
BEGIN
    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @EndUserName NVARCHAR(50) = 'End User Name';
    DECLARE @EndUserPassword NVARCHAR(255) = 'End User Password';

    -- Create #output table to insert the returned data of the executed stored procedure to NOT print its results.
    CREATE TABLE #output (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(50),
        EndUserRoleID UNIQUEIDENTIFIER,
        EmployeeID UNIQUEIDENTIFIER
    );
    INSERT INTO #output EXEC [dbo].[usp_CreateEndUser] @EndUserName, @EndUserPassword;

    CREATE TABLE #expected (
        EndUserName NVARCHAR(50),
        EndUserPasswordHash NCHAR(32)
    );

    INSERT INTO #expected (EndUserName, EndUserPasswordHash)
    VALUES (
        @EndUserName,
        CONVERT(NCHAR(32), HASHBYTES('SHA2_256', @EndUserPassword))
    );

    SELECT
        EndUserName,
        EndUserPasswordHash
    INTO #actual
    FROM [dbo].[EndUser];

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;