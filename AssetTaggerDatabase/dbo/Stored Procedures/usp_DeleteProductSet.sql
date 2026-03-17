CREATE PROCEDURE [dbo].[usp_DeleteProductSet]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ParentProductID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteProductSet BIT = (SELECT DeleteProductSet FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteProductSet IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteProductSet = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[ProductSet]
    OUTPUT
        DELETED.ParentProductID,
        DELETED.ProductID,
        DELETED.ProductSetProductQuantity,
        DELETED.ProductSetInsertDate
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductID = @ParentProductID
        AND ProductID = ISNULL(@ProductID, ProductID);
END;
