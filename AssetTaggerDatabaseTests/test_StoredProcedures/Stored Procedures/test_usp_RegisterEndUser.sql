CREATE PROCEDURE [test_StoredProcedures].[test_usp_RegisterEndUser]
AS
BEGIN
    EXEC TSQLt.FakeTable '[dbo].[EndUser]', @Defaults = 1;

    DECLARE @EndUserName NVARCHAR(50) = 'End User Name';
    DECLARE @EndUserPassword NVARCHAR(255) = 'End User Password';

    CREATE TABLE #output (EndUserID UNIQUEIDENTIFIER);
    INSERT INTO #output EXEC [dbo].[usp_RegisterEndUser] @EndUserName, @EndUserPassword;

    DECLARE @EndUserID UNIQUEIDENTIFIER = (SELECT EndUserID FROM #output);

    CREATE TABLE #expected (
        EndUserID UNIQUEIDENTIFIER,
        EndUserName NVARCHAR(50),
        EndUserPasswordHash NCHAR(32)
    );

    INSERT INTO #expected (EndUserID, EndUserName, EndUserPasswordHash)
    VALUES (
        @EndUserID,
        @EndUserName,
        CONVERT(NCHAR(32), HASHBYTES('SHA2_256', @EndUserPassword))
    );

    SELECT
        EndUserID,
        EndUserName,
        EndUserPasswordHash
    INTO #actual
    FROM [dbo].[EndUser];

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
