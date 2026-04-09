CREATE PROCEDURE [dbo].[usp_UpdateProductSet]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @ParentProductID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER = NULL,
    @ProductQuantity INT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingProductSetPermission BIT = (SELECT HasUpdatingProductSetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingProductSetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingProductSetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[ProductSet]
    SET
        ProductQuantity = ISNULL(@ProductQuantity, ProductQuantity)
    OUTPUT
        INSERTED.ParentProductID,
        INSERTED.ProductID,
        INSERTED.ProductQuantity,
        INSERTED.CreatedAt,
        DELETED.ProductQuantity AS OldProductQuantity
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductID = @ParentProductID
        AND ProductID = ISNULL(@ProductID, ProductID);
END;
