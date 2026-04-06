CREATE PROCEDURE [dbo].[usp_DeleteProduct]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingProductPermission BIT = (SELECT HasDeletingProductPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingProductPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingProductPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Product!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Product]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.ModelNumber,
        DELETED.DocumentationUrl,
        DELETED.ManufacturerId,
        DELETED.CategoryId,
        DELETED.CreatedAt
    FROM
        [dbo].[Product]
    WHERE
        Id = @Id;
END;
