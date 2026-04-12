CREATE PROCEDURE [dbo].[usp_UpdateVendor]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Vendor';

    -- Run actual query.
    UPDATE
        [dbo].[Vendor]
    SET
        Name = COALESCE(@Name, Name),
        Address = COALESCE(@Address, Address)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.Address,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName,
        DELETED.Address AS OldAddress
    FROM
        [dbo].[Vendor]
    WHERE
        Id = @Id;
END;
