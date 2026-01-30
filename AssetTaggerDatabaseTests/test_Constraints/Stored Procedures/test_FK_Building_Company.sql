CREATE PROCEDURE [test_Constraints].[test_FK_Building_Company]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC TSQLt.FakeTable '[dbo].[Building]';
    -- Apply foreign key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[Building]', '[FK_Building_Company]';

    -- Test foreign key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Building] (CompanyID) VALUES
    (NEWID());
END;
