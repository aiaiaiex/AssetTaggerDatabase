CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Username NVARCHAR(850) = NULL,
    @EndUserRoleId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingEndUserPermission BIT = (SELECT HasUpdatingEndUserPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update an EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Validate input.
    IF (@Username IS NULL AND @EndUserRoleId IS NULL AND @EmployeeId IS NULL)
        BEGIN
            RAISERROR ('Cannot update row with @Id when no non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[EndUser]
    SET
        Username = ISNULL(@Username, Username),
        EndUserRoleId = ISNULL(@EndUserRoleId, EndUserRoleId),
        EmployeeId = ISNULL(@EmployeeId, EmployeeId)
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
