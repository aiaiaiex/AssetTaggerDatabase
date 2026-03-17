CREATE PROCEDURE [dbo].[usp_CreateProductSet]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ParentProductID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER,
    @ProductSetProductQuantity INT = 1
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateProductSet BIT = (SELECT CreateProductSet FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateProductSet IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateProductSet = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a ProductSet!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[ProductSet] (
        ParentProductID,
        ProductID,
        ProductSetProductQuantity
    )
    OUTPUT
        INSERTED.ParentProductID,
        INSERTED.ProductID,
        INSERTED.ProductSetProductQuantity,
        INSERTED.ProductSetInsertDate
    VALUES (
        @ParentProductID,
        @ProductID,
        @ProductSetProductQuantity
    );
END;
