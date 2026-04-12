CREATE PROCEDURE [dbo].[usp_CreateVendor]
    @CallingEndUserId NVARCHAR(36),
    @Name NVARCHAR(850),
    @Address NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Vendor';

    -- Run actual query.
    INSERT INTO [dbo].[Vendor] (
        Name,
        Address
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CreatedAt
    VALUES (
        @Name,
        @Address
    );
END;
