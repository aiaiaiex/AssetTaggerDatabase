CREATE PROCEDURE [test_Constraints].[test_DF_Category_CategoryID]
AS
BEGIN
    -- Create dummy data for Category.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Category]', @Defaults = 1;

    DECLARE @CategoryName NVARCHAR(4000) = 'Category Name 01';

    INSERT INTO [dbo].[Category] (CategoryName) VALUES
    (@CategoryName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = CategoryID FROM [dbo].[Category];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
