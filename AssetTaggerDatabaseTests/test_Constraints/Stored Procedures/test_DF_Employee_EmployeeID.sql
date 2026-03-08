CREATE PROCEDURE [test_Constraints].[test_DF_Employee_EmployeeID]
AS
BEGIN
    -- Create dummy data for Employee.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[Employee]', @Defaults = 1;

    DECLARE @EmployeeFullName NVARCHAR(4000) = 'Guil Pobre';

    INSERT INTO [dbo].[Employee] (EmployeeFullName) VALUES
    (@EmployeeFullName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = EmployeeID FROM [dbo].[Employee];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
