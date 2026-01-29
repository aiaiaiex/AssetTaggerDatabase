CREATE PROCEDURE [test_Constraints].[test_PK_Vendor]
AS
BEGIN
    -- Create dummy data for Vendor.
    EXEC TSQLt.FakeTable '[dbo].[Vendor]';

    DECLARE @VendorID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Vendor]', '[PK_Vendor]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Vendor] (VendorID) VALUES
    (@VendorID),
    (@VendorID);
END;
