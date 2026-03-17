CREATE PROCEDURE [dbo].[usp_UpdateVendor]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @VendorID UNIQUEIDENTIFIER,
    @VendorName NVARCHAR(850) = NULL,
    @VendorAddress NVARCHAR(850) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateVendor BIT;
    SELECT @UpdateVendor = (SELECT UpdateVendor FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateVendor IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@UpdateVendor = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Vendor!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    UPDATE [dbo].[Vendor]
    SET VendorName = ISNULL(@VendorName, VendorName), VendorAddress = ISNULL(@VendorAddress, VendorAddress)
    OUTPUT INSERTED.VendorID, INSERTED.VendorName, INSERTED.VendorAddress, INSERTED.VendorInsertDate, DELETED.VendorName AS OldVendorName, DELETED.VendorAddress AS OldVendorAddress
    FROM [dbo].[Vendor]
    WHERE VendorID = @VendorID;
END
