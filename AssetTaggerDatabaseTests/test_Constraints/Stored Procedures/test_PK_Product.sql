
CREATE PROCEDURE [test_Constraints].[test_PK_Product]
AS
BEGIN
    -- Create dummy data for Product.
    EXEC tSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Product]', '[PK_Product]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[Product] (ProductID) VALUES
    (@ProductID),
    (@ProductID);
END;