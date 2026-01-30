CREATE PROCEDURE [test_Constraints].[test_FK_AssetTransfer_Company_CompanyID]
AS
BEGIN
    -- Create dummy data for AssetTransfer.
    EXEC TSQLt.FakeTable '[dbo].[AssetTransfer]';

    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[AssetTransfer]', '[FK_AssetTransfer_Company_CompanyID]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[AssetTransfer] (CompanyID) VALUES
    (NEWID());
END;
