CREATE PROCEDURE [test_Constraints].[test_AK_Company_CompanyAddress]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyAddress NVARCHAR(50) = 'Company Address 01';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Company]', '[AK_Company_CompanyAddress]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Company] (CompanyAddress) VALUES
    (@CompanyAddress),
    (@CompanyAddress);
END;
