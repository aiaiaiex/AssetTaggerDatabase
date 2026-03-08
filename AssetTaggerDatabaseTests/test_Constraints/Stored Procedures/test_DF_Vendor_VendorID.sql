CREATE PROCEDURE [test_Constraints].[test_DF_Vendor_VendorID]
AS
BEGIN
    -- Create dummy data for Vendor.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Vendor]', @Defaults = 1;

    DECLARE @VendorName NVARCHAR(4000) = 'Vendor Name 01';

    INSERT INTO [dbo].[Vendor] (VendorName) VALUES
    (@VendorName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = VendorID FROM [dbo].[Vendor];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
