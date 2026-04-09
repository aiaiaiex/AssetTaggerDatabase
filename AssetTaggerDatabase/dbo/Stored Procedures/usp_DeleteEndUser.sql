CREATE PROCEDURE [dbo].[usp_DeleteEndUser]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingEndUserPermission BIT = (SELECT HasDeletingEndUserPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete an EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[EndUser]
    OUTPUT
        DELETED.Id,
        DELETED.Username,
        DELETED.EndUserRoleID,
        DELETED.EmployeeID,
        DELETED.CreatedAt
    FROM
        [dbo].[EndUser]
    WHERE
        Id = @Id;
END;
