-- Values of variables below are changeable, especially @Username and @Password.
DECLARE @Username NVARCHAR(850) = 'username';
DECLARE @Password NVARCHAR(MAX) = 'password';
DECLARE @RoleName NVARCHAR(850) = 'admin';

-- Create Role.
CREATE TABLE #RoleIdTable (RoleId UNIQUEIDENTIFIER);
DECLARE @RoleId UNIQUEIDENTIFIER;

INSERT INTO [dbo].[Role]
(
    -- Non-nullable columns.
    [Name]
)
OUTPUT INSERTED.Id
INTO #RoleIdTable
VALUES
(
    -- Non-nullable columns.
    @RoleName
);

SET @RoleId = (SELECT RoleId FROM #RoleIdTable);
DROP TABLE #RoleIdTable;

-- Create Permissions.
INSERT INTO [dbo].[Permission]
(
    -- Non-nullable foreign keys.
    RoleId,
    -- Non-nullable columns.
    Operation,
    TableName
)
VALUES
-- Asset CRUD Permissions.
(@RoleId, 'Create', 'Asset'),
(@RoleId, 'Read', 'Asset'),
(@RoleId, 'Update', 'Asset'),
(@RoleId, 'Delete', 'Asset'),
-- Building CRUD Permissions.
(@RoleId, 'Create', 'Building'),
(@RoleId, 'Read', 'Building'),
(@RoleId, 'Update', 'Building'),
(@RoleId, 'Delete', 'Building'),
-- Category CRUD Permissions.
(@RoleId, 'Create', 'Category'),
(@RoleId, 'Read', 'Category'),
(@RoleId, 'Update', 'Category'),
(@RoleId, 'Delete', 'Category'),
-- Company CRUD Permissions.
(@RoleId, 'Create', 'Company'),
(@RoleId, 'Read', 'Company'),
(@RoleId, 'Update', 'Company'),
(@RoleId, 'Delete', 'Company'),
-- Department CRUD Permissions.
(@RoleId, 'Create', 'Department'),
(@RoleId, 'Read', 'Department'),
(@RoleId, 'Update', 'Department'),
(@RoleId, 'Delete', 'Department'),
-- Employee CRUD Permissions.
(@RoleId, 'Create', 'Employee'),
(@RoleId, 'Read', 'Employee'),
(@RoleId, 'Update', 'Employee'),
(@RoleId, 'Delete', 'Employee'),
-- EndUser CRUD Permissions.
(@RoleId, 'Create', 'EndUser'),
(@RoleId, 'Read', 'EndUser'),
(@RoleId, 'Update', 'EndUser'),
(@RoleId, 'Delete', 'EndUser'),
-- InHouseUnit CRUD Permissions.
(@RoleId, 'Create', 'InHouseUnit'),
(@RoleId, 'Read', 'InHouseUnit'),
(@RoleId, 'Update', 'InHouseUnit'),
(@RoleId, 'Delete', 'InHouseUnit'),
-- Job CRUD Permissions.
(@RoleId, 'Create', 'Job'),
(@RoleId, 'Read', 'Job'),
(@RoleId, 'Update', 'Job'),
(@RoleId, 'Delete', 'Job'),
-- Location CRUD Permissions.
(@RoleId, 'Create', 'Location'),
(@RoleId, 'Read', 'Location'),
(@RoleId, 'Update', 'Location'),
(@RoleId, 'Delete', 'Location'),
-- Log R Permission.
(@RoleId, 'Read', 'Log'),
-- Manufacturer CRUD Permissions.
(@RoleId, 'Create', 'Manufacturer'),
(@RoleId, 'Read', 'Manufacturer'),
(@RoleId, 'Update', 'Manufacturer'),
(@RoleId, 'Delete', 'Manufacturer'),
-- Permission CRUD Permissions.
(@RoleId, 'Create', 'Permission'),
(@RoleId, 'Read', 'Permission'),
(@RoleId, 'Update', 'Permission'),
(@RoleId, 'Delete', 'Permission'),
-- Product CRUD Permissions.
(@RoleId, 'Create', 'Product'),
(@RoleId, 'Read', 'Product'),
(@RoleId, 'Update', 'Product'),
(@RoleId, 'Delete', 'Product'),
-- ProductSet CRUD Permissions.
(@RoleId, 'Create', 'ProductSet'),
(@RoleId, 'Read', 'ProductSet'),
(@RoleId, 'Update', 'ProductSet'),
(@RoleId, 'Delete', 'ProductSet'),
-- Role CRUD Permissions.
(@RoleId, 'Create', 'Role'),
(@RoleId, 'Read', 'Role'),
(@RoleId, 'Update', 'Role'),
(@RoleId, 'Delete', 'Role'),
-- Vendor CRUD Permissions.
(@RoleId, 'Create', 'Vendor'),
(@RoleId, 'Read', 'Vendor'),
(@RoleId, 'Update', 'Vendor'),
(@RoleId, 'Delete', 'Vendor');

-- Create EndUser.
DECLARE @PasswordSalt UNIQUEIDENTIFIER = NEWID();

INSERT INTO [dbo].[EndUser]
(
    -- Non-nullable foreign keys.
    [RoleId],
    -- Non-nullable columns.
    [Username],
    -- Secret columns.
    [PasswordHash],
    [PasswordSalt]
)
OUTPUT
    -- Non-nullable columns with default values.
    INSERTED.CreatedAt,
    INSERTED.Id,
    -- Non-nullable foreign keys.
    INSERTED.RoleId,
    -- Nullable foreign keys.
    INSERTED.EmployeeId,
    -- Non-nullable columns.
    INSERTED.Username
VALUES
(
    -- Non-nullable foreign keys.
    @RoleId,
    -- Non-nullable columns.
    @Username,
    -- Secret columns.
    [dbo].[udf_HashPassword](CONCAT(@Password, CAST(@PasswordSalt AS NVARCHAR(36)))),
    @PasswordSalt
);
