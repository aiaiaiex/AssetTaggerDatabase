CREATE PROCEDURE [test_Constraints].[test_CTK_ProductSet_ParentProductID_ProductID]
AS
BEGIN
    -- Create dummy data for ProductSet.
    EXEC TSQLt.FakeTable '[dbo].[ProductSet]';

    DECLARE @ProductID UNIQUEIDENTIFIER = NEWID();

    -- Apply check constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[ProductSet]', '[CTK_ProductSet_ParentProductID_ProductID]';

    -- Test check constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting unacceptable data.
    INSERT INTO [dbo].[ProductSet] (ParentProductID, ProductID) VALUES
    (@ProductID, @ProductID);
END;
