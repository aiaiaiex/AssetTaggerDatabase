CREATE PROCEDURE [test_Constraints].[test_PK_Company]
AS
BEGIN
    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Company]', '[PK_Company]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Company] (CompanyID) VALUES
    (@CompanyID),
    (@CompanyID);
END;
