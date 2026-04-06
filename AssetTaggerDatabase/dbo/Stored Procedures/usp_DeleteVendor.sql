CREATE PROCEDURE [dbo].[usp_DeleteVendor]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingVendorPermission BIT = (SELECT HasDeletingVendorPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingVendorPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingVendorPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Vendor!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Vendor]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.Address,
        DELETED.CreatedAt
    FROM
        [dbo].[Vendor]
    WHERE
        Id = @Id;
END;
