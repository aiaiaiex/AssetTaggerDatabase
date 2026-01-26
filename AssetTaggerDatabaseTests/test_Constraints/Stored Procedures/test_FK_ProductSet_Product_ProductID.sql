
CREATE PROCEDURE [test_Constraints].[test_FK_ProductSet_Product_ProductID]
AS
BEGIN
    -- Create dummy data for ProductSet.
    EXEC tSQLt.FakeTable '[dbo].[ProductSet]';

    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[ProductSet]', '[FK_ProductSet_Product_ProductID]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[ProductSet] (ProductID) VALUES
    (NEWID());
END;