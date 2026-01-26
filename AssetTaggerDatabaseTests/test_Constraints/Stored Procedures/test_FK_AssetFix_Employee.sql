
CREATE PROCEDURE [test_Constraints].[test_FK_AssetFix_Employee]
AS
BEGIN
    -- Create dummy data for AssetFix.
    EXEC tSQLt.FakeTable '[dbo].[AssetFix]';
    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[AssetFix]', '[FK_AssetFix_Employee]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[AssetFix] (EmployeeID) VALUES
    (NEWID());
END;