CREATE PROCEDURE [test_Constraints].[test_DF_Department_DepartmentID]
AS
BEGIN
    -- Create dummy data for Department.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Department]', @Defaults = 1;

    DECLARE @DepartmentName NVARCHAR(4000) = 'Department Name 01';

    INSERT INTO [dbo].[Department] (DepartmentName) VALUES
    (@DepartmentName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = DepartmentID FROM [dbo].[Department];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
