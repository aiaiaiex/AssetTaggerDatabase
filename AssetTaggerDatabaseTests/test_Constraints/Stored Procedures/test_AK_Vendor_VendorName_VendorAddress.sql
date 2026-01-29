CREATE PROCEDURE [test_Constraints].[test_AK_Vendor_VendorName_VendorAddress]
AS
BEGIN
    -- Create dummy data for Vendor.
    EXEC TSQLt.FakeTable '[dbo].[Vendor]';

    DECLARE @VendorName NVARCHAR(50) = 'Vendor Name 01';
    DECLARE @VendorAddress NVARCHAR(50) = 'Vendor Address 01';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Vendor]', '[AK_Vendor_VendorName_VendorAddress]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Vendor] (VendorName, VendorAddress) VALUES
    (@VendorName, @VendorAddress),
    (@VendorName, @VendorAddress);
END;
