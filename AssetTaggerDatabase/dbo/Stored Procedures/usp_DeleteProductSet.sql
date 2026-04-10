CREATE PROCEDURE [dbo].[usp_DeleteProductSet]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @ParentProductId UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingProductSetPermission BIT = (SELECT HasDeletingProductSetPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingProductSetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingProductSetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[ProductSet]
    OUTPUT
        DELETED.ParentProductId,
        DELETED.ProductId,
        DELETED.ProductQuantity,
        DELETED.CreatedAt
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductId = @ParentProductId
        AND ProductId = COALESCE(@ProductId, ProductId);
END;
