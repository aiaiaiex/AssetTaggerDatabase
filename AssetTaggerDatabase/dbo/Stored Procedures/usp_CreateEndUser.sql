CREATE PROCEDURE [dbo].[usp_CreateEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserName NVARCHAR(4000),
    @EndUserPassword NVARCHAR(MAX),
    @EndUserRoleID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateEndUser BIT;
    SELECT @CreateEndUser = (SELECT CreateEndUser FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateEndUser IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@CreateEndUser = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create an EndUser!', 11, 0);
            RETURN -1;
        END

    -- Create password salt.
    DECLARE @EndUserPasswordSalt UNIQUEIDENTIFIER = NEWID();

    -- Run actual query.
    INSERT INTO [dbo].[EndUser] (EndUserName, EndUserPasswordHash, EndUserPasswordSalt, EndUserRoleID, EmployeeID)
    OUTPUT INSERTED.EndUserID, INSERTED.EndUserName, INSERTED.EndUserRoleID, INSERTED.EmployeeID, INSERTED.EndUserRegisterDate
    VALUES (
        @EndUserName,
        [dbo].[udf_HashPassword](CONCAT(@EndUserPassword, CONVERT(NVARCHAR(36), @EndUserPasswordSalt))),
        @EndUserPasswordSalt,
        @EndUserRoleID,
        @EmployeeID
    );
END
