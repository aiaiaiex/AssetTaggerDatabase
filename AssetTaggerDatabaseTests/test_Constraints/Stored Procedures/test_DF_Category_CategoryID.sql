
CREATE PROCEDURE [test_Constraints].[test_DF_Category_CategoryID]
AS
BEGIN
    -- Create dummy data for Category.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[Category]', @Defaults=1;

    DECLARE @CategoryName NVARCHAR(50) = 'Category Name 01';

    INSERT INTO [dbo].[Category] (CategoryName) VALUES
    (@CategoryName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = CategoryID from [dbo].[Category];

    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;