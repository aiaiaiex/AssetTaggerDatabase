CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @Username NVARCHAR(850) = NULL,
    @EndUserRoleId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'EndUser';

    -- Run actual query.
    UPDATE
        [dbo].[EndUser]
    SET
        Username = COALESCE(@Username, Username),
        EndUserRoleId = COALESCE(@EndUserRoleId, EndUserRoleId),
        EmployeeId = COALESCE(@EmployeeId, EmployeeId)
    OUTPUT
        INSERTED.Id,
        INSERTED.Username,
        INSERTED.EndUserRoleId,
        INSERTED.EmployeeId,
        INSERTED.CreatedAt,
        DELETED.Username AS OldUsername,
        DELETED.EndUserRoleId AS OldEndUserRoleId,
        DELETED.EmployeeId AS OldEmployeeId
    FROM
        [dbo].[EndUser]
    WHERE
        Id = @Id;
END;
