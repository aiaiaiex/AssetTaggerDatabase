CREATE PROCEDURE [dbo].[usp_CreateEndUser]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Username NVARCHAR(850),
    @Password NVARCHAR(MAX),
    @EndUserRoleId UNIQUEIDENTIFIER,
    @EmployeeId UNIQUEIDENTIFIER
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
        EndUserRoleId,
        EmployeeId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Username,
        INSERTED.EndUserRoleId,
        INSERTED.EmployeeId,
        INSERTED.CreatedAt
    VALUES (
        @Username,
        @PasswordSalt,
        [dbo].[udf_HashPassword](CONCAT(@Password, CONVERT(NVARCHAR(36), @PasswordSalt))),
        @EndUserRoleId,
        @EmployeeId
    );
END;
