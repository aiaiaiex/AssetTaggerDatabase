
CREATE PROCEDURE [test_Constraints].[test_DF_Department_DepartmentID]
AS
BEGIN
    -- Create dummy data for Department.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[Department]', @Defaults=1;

    DECLARE @DepartmentName NVARCHAR(50) = 'Department Name 01';

    INSERT INTO [dbo].[Department] (DepartmentName) VALUES
    (@DepartmentName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = DepartmentID from [dbo].[Department];

    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;