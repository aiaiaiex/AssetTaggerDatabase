CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetProductsOfProductSet_ReturnsCorrectChildProducts]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[ProductSet]';

    DECLARE @TargetParentID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherParentID UNIQUEIDENTIFIER = NEWID();

    DECLARE @ChildProd1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ChildProd2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseProd UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[ProductSet] (ParentProductID, ProductID)
    VALUES
    (@TargetParentID, @ChildProd1),
    (@TargetParentID, @ChildProd2),
    (@OtherParentID, @NoiseProd);

    CREATE TABLE #actual (ProductID UNIQUEIDENTIFIER);

    INSERT INTO #actual (ProductID)
    EXEC [dbo].[usp_GetProductsOfProductSet] @ParentProductID = @TargetParentID;

    CREATE TABLE #expected (ProductID UNIQUEIDENTIFIER);
    INSERT INTO #expected (ProductID) VALUES (@ChildProd1), (@ChildProd2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
