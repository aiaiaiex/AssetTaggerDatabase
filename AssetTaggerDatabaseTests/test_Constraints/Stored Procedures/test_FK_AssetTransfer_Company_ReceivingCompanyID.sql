
CREATE PROCEDURE [test_Constraints].[test_FK_AssetTransfer_Company_ReceivingCompanyID]
AS
BEGIN
    -- Create dummy data for AssetTransfer.
    EXEC tSQLt.FakeTable '[dbo].[AssetTransfer]';

    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[AssetTransfer]', '[FK_AssetTransfer_Company_ReceivingCompanyID]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[AssetTransfer] (ReceivingCompanyID) VALUES
    (NEWID());
END;