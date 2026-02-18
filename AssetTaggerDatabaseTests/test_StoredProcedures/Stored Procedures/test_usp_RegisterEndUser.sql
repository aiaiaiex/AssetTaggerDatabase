
CREATE PROCEDURE [test_StoredProcedures].[test_usp_RegisterEndUser]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @UserName NVARCHAR(50) = 'NewUser';
    DECLARE @PlainPassword NVARCHAR(255) = 'MyPassword123';

    EXEC [dbo].[usp_RegisterEndUser]
        @EndUserName = @UserName,
        @EndUserPassword = @PlainPassword;

    CREATE TABLE #expected (
        EndUserName NVARCHAR(50),
        EndUserPasswordHash NCHAR(32)
    );

    INSERT INTO #expected (EndUserName, EndUserPasswordHash)
    VALUES (
        @UserName,
        CONVERT(NCHAR(32), HASHBYTES('SHA2_256', @PlainPassword))
    );

    SELECT
        EndUserName,
        EndUserPasswordHash
    INTO #actual
    FROM [dbo].[EndUser];

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;