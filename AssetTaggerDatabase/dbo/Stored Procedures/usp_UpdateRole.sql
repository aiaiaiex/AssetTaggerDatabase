CREATE PROCEDURE [dbo].[usp_UpdateRole]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingRolePermission BIT = (SELECT HasUpdatingRolePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingRolePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingRolePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Role!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Role]
    SET
        Name = ISNULL(@Name, Name)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName
    FROM
        [dbo].[Role]
    WHERE
        Id = @Id;
END;
