CREATE PROCEDURE [test_Constraints].[test_DF_Company_CompanyID]
AS
BEGIN
    -- Create dummy data for Company.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Company]', @Defaults = 1;

    DECLARE @CompanyName NVARCHAR(50) = 'Company Name 01';

    INSERT INTO [dbo].[Company] (CompanyName) VALUES
    (@CompanyName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = CompanyID FROM [dbo].[Company];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
