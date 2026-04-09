CREATE PROCEDURE [dbo].[usp_CreateProductSet]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @ParentProductId UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER,
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
        ParentProductId,
        ProductId,
        ProductQuantity
    )
    OUTPUT
        INSERTED.ParentProductId,
        INSERTED.ProductId,
        INSERTED.ProductQuantity,
        INSERTED.CreatedAt
    VALUES (
        @ParentProductId,
        @ProductId,
        ISNULL(@ProductQuantity, 1)
    );
END;
