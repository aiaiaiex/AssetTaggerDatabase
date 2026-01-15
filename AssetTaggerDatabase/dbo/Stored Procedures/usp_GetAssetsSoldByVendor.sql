CREATE PROCEDURE [dbo].[usp_GetAssetsSoldByVendor]
    @VendorID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        AssetID
    FROM [dbo].[Asset] 
    WHERE VendorID = @VendorID;
END
