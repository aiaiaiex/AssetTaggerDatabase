CREATE PROCEDURE [dbo].[usp_CreateEndUser]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Username NVARCHAR(850),
    @Password NVARCHAR(MAX),
    @EndUserRoleID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingEndUserPermission BIT = (SELECT HasCreatingEndUserPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create an EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Create password salt.
    DECLARE @PasswordSalt UNIQUEIDENTIFIER = NEWID();

    -- Run actual query.
    INSERT INTO [dbo].[EndUser] (
        Username,
        PasswordSalt,
        PasswordHash,
        EndUserRoleID,
        EmployeeID
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Username,
        INSERTED.EndUserRoleID,
        INSERTED.EmployeeID,
        INSERTED.CreatedAt
    VALUES (
        @Username,
        @PasswordSalt,
        [dbo].[udf_HashPassword](CONCAT(@Password, CONVERT(NVARCHAR(36), @PasswordSalt))),
        @EndUserRoleID,
        @EmployeeID
    );
END;
