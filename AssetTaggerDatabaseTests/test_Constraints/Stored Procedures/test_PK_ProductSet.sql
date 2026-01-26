
CREATE PROCEDURE [test_Constraints].[test_PK_ProductSet]
AS
BEGIN
    -- Create dummy data for ProductSet.
    EXEC tSQLt.FakeTable '[dbo].[ProductSet]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[ProductSet]', '[PK_ProductSet]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[ProductSet] (ParentProductID, ProductID) VALUES
    (@ProductID01, @ProductID02),
    (@ProductID01, @ProductID02);
END;