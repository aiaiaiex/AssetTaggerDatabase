
CREATE PROCEDURE [test_Constraints].[test_DF_Employee_EmployeeID]
AS
BEGIN
    -- Create dummy data for Employee.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[Employee]', @Defaults=1;

    DECLARE @EmployeeFullName NVARCHAR(50) = 'Guil Pobre';

    INSERT INTO [dbo].[Employee] (EmployeeFullName) VALUES
    (@EmployeeFullName);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = EmployeeID from [dbo].[Employee];
    
    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;