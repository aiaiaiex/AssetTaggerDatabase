CREATE PROCEDURE [dbo].[usp_CreateRole]
    @CallingEndUserId NVARCHAR(36),
    @Name NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Role';

    -- Run actual query.
    INSERT INTO [dbo].[Role] (
        Name
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.CreatedAt
    VALUES (
        @Name
    );
END;
