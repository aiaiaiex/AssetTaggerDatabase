CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Username NVARCHAR(850) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingEndUserPermission BIT = (SELECT HasUpdatingEndUserPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Validate input.
    IF (@Username IS NULL AND @EndUserRoleID IS NULL AND @EmployeeID IS NULL)
        BEGIN
            RAISERROR ('Cannot update row with @Id when no non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[EndUser]
    SET
        Username = ISNULL(@Username, Username),
        EndUserRoleID = ISNULL(@EndUserRoleID, EndUserRoleID),
        EmployeeID = ISNULL(@EmployeeID, EmployeeID)
    OUTPUT
        INSERTED.Id,
        INSERTED.Username,
        INSERTED.EndUserRoleID,
        INSERTED.EmployeeID,
        INSERTED.CreatedAt,
        DELETED.Username AS OldUsername,
        DELETED.EndUserRoleID AS OldEndUserRoleID,
        DELETED.EmployeeID AS OldEmployeeID
    FROM
        [dbo].[EndUser]
    WHERE
        Id = @Id;
END;
