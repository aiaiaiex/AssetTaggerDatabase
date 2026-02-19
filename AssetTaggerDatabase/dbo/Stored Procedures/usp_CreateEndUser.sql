CREATE PROCEDURE [dbo].[usp_CreateEndUser]
    @EndUserName NVARCHAR(50),
    @EndUserPassword NVARCHAR(255),
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[EndUser] (EndUserName, EndUserPasswordHash, EndUserRoleID, EmployeeID)
    OUTPUT INSERTED.EndUserID, INSERTED.EndUserName, INSERTED.EndUserRoleID, INSERTED.EmployeeID
    VALUES (
        @EndUserName,
        CONVERT(NCHAR(32), HASHBYTES('SHA2_256', @EndUserPassword)),
        -- CAST(HASHBYTES('SHA2_256', @EndUserPassword) AS NCHAR(32)),
        @EndUserRoleID,
        @EmployeeID
    );
END
