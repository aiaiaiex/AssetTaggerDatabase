CREATE PROCEDURE [dbo].[usp_CreateManufacturer]
    @CallingEndUserId NVARCHAR(36),
    @Name NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Manufacturer';

    -- Run actual query.
    INSERT INTO [dbo].[Manufacturer] (
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
