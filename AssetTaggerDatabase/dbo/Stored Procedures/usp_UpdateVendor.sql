CREATE PROCEDURE [dbo].[usp_UpdateVendor]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(850) = NULL,
    @Address NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingVendorPermission BIT = (SELECT HasUpdatingVendorPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingVendorPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingVendorPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Vendor!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Vendor]
    SET
        Name = ISNULL(@Name, Name),
        Address = ISNULL(@Address, Address)
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
