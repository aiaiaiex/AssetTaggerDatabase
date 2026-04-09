CREATE PROCEDURE [dbo].[usp_DeleteDepartment]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingDepartmentPermission BIT = (SELECT HasDeletingDepartmentPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingDepartmentPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingDepartmentPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a Department!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Department]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.CreatedAt
    FROM
        [dbo].[Department]
    WHERE
        Id = @Id;
END;
