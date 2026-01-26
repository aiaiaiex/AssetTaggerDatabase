
CREATE PROCEDURE [test_Constraints].[test_AK_Company_CompanyCode]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC tSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyCode NVARCHAR(50) = 'Code1';

    -- Apply unique (alternate key) constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Company]', '[AK_Company_CompanyCode]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Company] (CompanyCode) VALUES
    (@CompanyCode),
    (@CompanyCode);
END;