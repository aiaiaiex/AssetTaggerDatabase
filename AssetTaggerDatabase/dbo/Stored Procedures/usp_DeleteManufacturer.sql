CREATE PROCEDURE [dbo].[usp_DeleteManufacturer]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingManufacturerPermission BIT = (SELECT HasDeletingManufacturerPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingManufacturerPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingManufacturerPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Manufacturer!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Manufacturer]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.CreatedAt
    FROM
        [dbo].[Manufacturer]
    WHERE
        Id = @Id;
END;
