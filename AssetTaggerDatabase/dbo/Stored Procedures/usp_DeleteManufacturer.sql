CREATE PROCEDURE [dbo].[usp_DeleteManufacturer]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingManufacturerPermission BIT = (SELECT HasDeletingManufacturerPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingManufacturerPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingManufacturerPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a Manufacturer!', 11, 0);
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
