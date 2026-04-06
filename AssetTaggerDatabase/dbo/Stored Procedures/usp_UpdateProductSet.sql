CREATE PROCEDURE [dbo].[usp_UpdateProductSet]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ParentProductID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER = NULL,
    @ProductSetProductQuantity INT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingProductSetPermission BIT = (SELECT HasUpdatingProductSetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingProductSetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingProductSetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[ProductSet]
    SET
        ProductSetProductQuantity = ISNULL(@ProductSetProductQuantity, ProductSetProductQuantity)
    OUTPUT
        INSERTED.ParentProductID,
        INSERTED.ProductID,
        INSERTED.ProductSetProductQuantity,
        INSERTED.ProductSetInsertDate,
        DELETED.ProductSetProductQuantity AS OldProductSetProductQuantity
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductID = @ParentProductID
        AND ProductID = ISNULL(@ProductID, ProductID);
END;
