CREATE PROCEDURE [dbo].[usp_CreateProductSet]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @ParentProductID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER,
    @ProductQuantity INT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingProductSetPermission BIT = (SELECT HasCreatingProductSetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingProductSetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingProductSetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create a ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[ProductSet] (
        ParentProductID,
        ProductID,
        ProductQuantity
    )
    OUTPUT
        INSERTED.ParentProductID,
        INSERTED.ProductID,
        INSERTED.ProductQuantity,
        INSERTED.CreatedAt
    VALUES (
        @ParentProductID,
        @ProductID,
        ISNULL(@ProductQuantity, 1)
    );
END;
