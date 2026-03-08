CREATE PROCEDURE [test_Views].[test_VI_ReadableEmployee]
AS
BEGIN
    -- Create dummy data for Role.
    EXEC TSQLt.FakeTable '[dbo].[Role]';

    DECLARE @RoleID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @RoleID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @RoleName01 NVARCHAR(4000) = 'Role Name 01';
    DECLARE @RoleName02 NVARCHAR(4000) = 'Role Name 02';

    INSERT INTO [dbo].[Role] (
        RoleID,
        RoleName
    ) VALUES
    (
        @RoleID01,
        @RoleName01
    ),
    (
        @RoleID02,
        @RoleName02
    );

    -- Create dummy data for Company.
    EXEC TSQLt.FakeTable '[dbo].[Company]';

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CompanyName01 NVARCHAR(4000) = 'Company Name 01';
    DECLARE @CompanyName02 NVARCHAR(4000) = 'Company Name 02';

    INSERT INTO [dbo].[Company] (
        CompanyID,
        CompanyName
    ) VALUES
    (
        @CompanyID01,
        @CompanyName01
    ),
    (
        @CompanyID02,
        @CompanyName02
    );

    -- Create dummy data for Department.
    EXEC TSQLt.FakeTable '[dbo].[Department]';

    DECLARE @DepartmentID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @DepartmentID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @DepartmentName01 NVARCHAR(4000) = 'Department Name 01';
    DECLARE @DepartmentName02 NVARCHAR(4000) = 'Department Name 02';

    INSERT INTO [dbo].[Department] (
        DepartmentID,
        DepartmentName
    ) VALUES
    (
        @DepartmentID01,
        @DepartmentName01
    ),
    (
        @DepartmentID02,
        @DepartmentName02
    );

    -- Create dummy data for Employee.
    EXEC TSQLt.FakeTable '[dbo].[Employee]';

    DECLARE @EmployeeID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @EmployeeID02 UNIQUEIDENTIFIER = NEWID();

    DECLARE @EmployeeFullName01 NVARCHAR(4000) = 'Employee Full Name 01';
    DECLARE @EmployeeFullName02 NVARCHAR(4000) = 'Employee Full Name 02';

    INSERT INTO [dbo].[Employee] (
        EmployeeID,
        EmployeeFullName,
        RoleID,
        CompanyID,
        DepartmentID
    ) VALUES
    (
        @EmployeeID01,
        @EmployeeFullName01,
        @RoleID02,
        @CompanyID02,
        @DepartmentID02
    ),
    (
        @EmployeeID02,
        @EmployeeFullName02,
        @RoleID01,
        @CompanyID01,
        @DepartmentID01
    );

    -- Expected output.
    CREATE TABLE #expected (
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(4000),
        RoleID UNIQUEIDENTIFIER,
        RoleName NVARCHAR(4000),
        CompanyID UNIQUEIDENTIFIER,
        CompanyName NVARCHAR(4000),
        DepartmentID UNIQUEIDENTIFIER,
        DepartmentName NVARCHAR(4000)
    );

    INSERT INTO #expected VALUES
    (
        @EmployeeID01,
        @EmployeeFullName01,
        @RoleID02,
        @RoleName02,
        @CompanyID02,
        @CompanyName02,
        @DepartmentID02,
        @DepartmentName02
    ),
    (
        @EmployeeID02,
        @EmployeeFullName02,
        @RoleID01,
        @RoleName01,
        @CompanyID01,
        @CompanyName01,
        @DepartmentID01,
        @DepartmentName01
    );

    -- Actual output.
    CREATE TABLE #actual (
        EmployeeID UNIQUEIDENTIFIER,
        EmployeeFullName NVARCHAR(4000),
        RoleID UNIQUEIDENTIFIER,
        RoleName NVARCHAR(4000),
        CompanyID UNIQUEIDENTIFIER,
        CompanyName NVARCHAR(4000),
        DepartmentID UNIQUEIDENTIFIER,
        DepartmentName NVARCHAR(4000)
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[VI_ReadableEmployee];

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
