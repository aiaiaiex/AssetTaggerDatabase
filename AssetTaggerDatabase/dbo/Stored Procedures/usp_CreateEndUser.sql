CREATE PROCEDURE [dbo].[usp_CreateEndUser]
    @CallingEndUserId NVARCHAR(36),
    @Username NVARCHAR(850),
    @Password NVARCHAR(MAX),
    @EndUserRoleId UNIQUEIDENTIFIER,
    @EmployeeId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'EndUser';

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
        [dbo].[udf_HashPassword](CONCAT(@Password, CAST(@PasswordSalt AS NVARCHAR(36)))),
        @EndUserRoleId,
        @EmployeeId
    );
END;
