CREATE PROCEDURE [dbo].[usp_CreateVendor]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Name NVARCHAR(850),
    @Address NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingVendorPermission BIT = (SELECT HasCreatingVendorPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasCreatingVendorPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingVendorPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Vendor!', 11, 0);
            RETURN -1;
        END;

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
