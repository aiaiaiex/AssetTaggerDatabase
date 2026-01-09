CREATE PROCEDURE RegisterUser
    @NewUserName NVARCHAR(255),
    @PlainPassword NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Users (UserName, UserPasswordHash)
    VALUES (
        @NewUserName, 
        -- This converts the password to a 64-char hex string hash
        CONVERT(CHAR(64), HASHBYTES('SHA2_256', @PlainPassword), 2)
    );
END

EXEC RegisterUser
    @NewUserName = 'jdoesljhdsrtfkjhds', 
    @PlainPassword = 'secret_password_1';

EXEC RegisterUser
    @NewUserName = 'jsmithdgsdkjjhdfggaskhgds', 
    @PlainPassword = 'secret_password_2';

SELECT * FROM Users;

DROP PROCEDURE RegisterUsers;