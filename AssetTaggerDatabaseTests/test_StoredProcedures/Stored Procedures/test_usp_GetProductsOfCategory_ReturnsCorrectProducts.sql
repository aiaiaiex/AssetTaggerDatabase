CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetProductsOfCategory_ReturnsCorrectProducts]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[Product]';

    DECLARE @TargetCategoryID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherCategoryID UNIQUEIDENTIFIER = NEWID();

    DECLARE @Prod1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Prod2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseProd UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Product] (ProductID, CategoryID)
    VALUES
    (@Prod1, @TargetCategoryID),
    (@Prod2, @TargetCategoryID),
    (@NoiseProd, @OtherCategoryID);

    CREATE TABLE #actual (ProductID UNIQUEIDENTIFIER);

    INSERT INTO #actual (ProductID)
    EXEC [dbo].[usp_GetProductsOfCategory] @CategoryID = @TargetCategoryID;

    CREATE TABLE #expected (ProductID UNIQUEIDENTIFIER);
    INSERT INTO #expected (ProductID) VALUES (@Prod1), (@Prod2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
