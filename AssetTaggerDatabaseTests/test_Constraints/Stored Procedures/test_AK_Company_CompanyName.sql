CREATE PROCEDURE [test_Constraints].[test_AK_Company_CompanyName]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyName NVARCHAR(50) = 'Company Name 01';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Company]', '[AK_Company_CompanyName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Company] (CompanyName) VALUES
    (@CompanyName),
    (@CompanyName);
END;
