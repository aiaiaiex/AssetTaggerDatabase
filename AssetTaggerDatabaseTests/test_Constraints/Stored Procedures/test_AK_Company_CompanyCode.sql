CREATE PROCEDURE [test_Constraints].[test_AK_Company_CompanyCode]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyCode NVARCHAR(5) = 'Code1';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Company]', '[AK_Company_CompanyCode]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Company] (CompanyCode) VALUES
    (@CompanyCode),
    (@CompanyCode);
END;
