CREATE PROCEDURE [dbo].[usp_UpdateDepartment]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingDepartmentPermission BIT = (SELECT HasUpdatingDepartmentPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingDepartmentPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingDepartmentPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Department!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Department]
    SET
        Name = ISNULL(@Name, Name)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName
    FROM
        [dbo].[Department]
    WHERE
        Id = @Id;
END;
