CREATE PROCEDURE [test_Constraints].[test_FK_Product_Category]
AS
BEGIN
    -- Create dummy data for Product.
    EXEC TSQLt.FakeTable '[dbo].[Product]';
    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Product]', '[FK_Product_Category]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Product] (CategoryID) VALUES
    (NEWID());
END;
