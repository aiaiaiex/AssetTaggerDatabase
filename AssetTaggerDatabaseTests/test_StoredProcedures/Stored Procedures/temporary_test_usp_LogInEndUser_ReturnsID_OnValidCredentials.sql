CREATE PROCEDURE [test_StoredProcedures].[test_usp_LogInEndUser_ReturnsID_OnValidCredentials]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[EndUser]';

    DECLARE @TargetUserID UNIQUEIDENTIFIER = NEWID();
    DECLARE @UserName NVARCHAR(4000) = 'TestUser';
    DECLARE @PlainPassword NVARCHAR(4000) = 'Secret123!';

    DECLARE @PasswordHash NCHAR(32);
    SET @PasswordHash = [dbo].[udf_HashPassword](@PlainPassword);

    INSERT INTO [dbo].[EndUser] (EndUserID, EndUserName, EndUserPasswordHash)
    VALUES (@TargetUserID, @UserName, @PasswordHash);

    CREATE TABLE #actual (EndUserID UNIQUEIDENTIFIER);

    INSERT INTO #actual (EndUserID)
    EXEC [dbo].[usp_LogInEndUser]
        @EndUserName = @UserName,
        @EndUserPassword = @PlainPassword;

    CREATE TABLE #expected (EndUserID UNIQUEIDENTIFIER);
    INSERT INTO #expected (EndUserID) VALUES (@TargetUserID);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
