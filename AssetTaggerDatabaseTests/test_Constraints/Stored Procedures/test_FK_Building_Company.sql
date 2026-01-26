
CREATE PROCEDURE [test_Constraints].[test_FK_Building_Company]
AS
BEGIN
    -- Create dummy data for Building.
    EXEC tSQLt.FakeTable '[dbo].[Building]';
    -- Apply foreign key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[Building]', '[FK_Building_Company]';

    -- Test foreign key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 547;

    -- Create error by inserting data not from foreign table.
    INSERT INTO [dbo].[Building] (CompanyID) VALUES
    (NEWID());
END;