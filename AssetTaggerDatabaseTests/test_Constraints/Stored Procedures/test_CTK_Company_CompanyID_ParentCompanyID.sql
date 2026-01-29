CREATE PROCEDURE [test_Constraints].[test_CTK_Company_CompanyID_ParentCompanyID]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID UNIQUEIDENTIFIER = NEWID();

    -- Apply check constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Company]', '[CTK_Company_CompanyID_ParentCompanyID]';

    -- Test check constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting unacceptable data.
    INSERT INTO [dbo].[Company] (CompanyID, ParentCompanyID) VALUES
    (@CompanyID, @CompanyID);
END;
