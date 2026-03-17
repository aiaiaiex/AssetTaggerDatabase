CREATE PROCEDURE [dbo].[usp_DeleteProduct]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteProduct BIT = (SELECT DeleteProduct FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteProduct IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteProduct = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Product!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Product]
    OUTPUT
        DELETED.ProductID,
        DELETED.ProductName,
        DELETED.ProductModelNumber,
        DELETED.ProductDocumentationURL,
        DELETED.ManufacturerID,
        DELETED.CategoryID,
        DELETED.ProductInsertDate
    FROM
        [dbo].[Product]
    WHERE
        ProductID = @ProductID;
END;
