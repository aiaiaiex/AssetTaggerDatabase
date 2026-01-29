CREATE PROCEDURE [test_Constraints].[test_AK_Category_CategoryName]
AS
BEGIN
    -- Create dummy data for Category.
    EXEC TSQLt.FakeTable '[dbo].[Category]';
    DECLARE @CategoryName NVARCHAR(50) = 'Category Name 1';

    -- Apply unique (alternate key) constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Category]', '[AK_Category_CategoryName]';

    -- Test unique (alternate key) constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) data twice.
    INSERT INTO [dbo].[Category] (CategoryName) VALUES
    (@CategoryName),
    (@CategoryName);
END;
