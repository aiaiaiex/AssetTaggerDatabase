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
    [Name],
    -- Permissions.
    -- Asset CRUD Permissions.
    [HasCreatingAssetPermission], [HasReadingAssetPermission], [HasUpdatingAssetPermission], [HasDeletingAssetPermission],
    -- Building CRUD Permissions.
    [HasCreatingBuildingPermission], [HasReadingBuildingPermission], [HasUpdatingBuildingPermission], [HasDeletingBuildingPermission],
    -- Category CRUD Permissions.
    [HasCreatingCategoryPermission], [HasReadingCategoryPermission], [HasUpdatingCategoryPermission], [HasDeletingCategoryPermission],
    -- Company CRUD Permissions.
    [HasCreatingCompanyPermission], [HasReadingCompanyPermission], [HasUpdatingCompanyPermission], [HasDeletingCompanyPermission],
    -- Department CRUD Permissions.
    [HasCreatingDepartmentPermission], [HasReadingDepartmentPermission], [HasUpdatingDepartmentPermission], [HasDeletingDepartmentPermission],
    -- Employee CRUD Permissions.
    [HasCreatingEmployeePermission], [HasReadingEmployeePermission], [HasUpdatingEmployeePermission], [HasDeletingEmployeePermission],
    -- EndUser CRUD Permissions.
    [HasCreatingEndUserPermission], [HasReadingEndUserPermission], [HasUpdatingEndUserPermission], [HasDeletingEndUserPermission],
    -- Role CRUD Permissions.
    [HasCreatingRolePermission], [HasReadingRolePermission], [HasUpdatingRolePermission], [HasDeletingRolePermission],
    -- Location CRUD Permissions.
    [HasCreatingLocationPermission], [HasReadingLocationPermission], [HasUpdatingLocationPermission], [HasDeletingLocationPermission],
    -- Log R Permissions.
    [HasReadingLogPermission],
    -- Manufacturer CRUD Permissions.
    [HasCreatingManufacturerPermission], [HasReadingManufacturerPermission], [HasUpdatingManufacturerPermission], [HasDeletingManufacturerPermission],
    -- Product CRUD Permissions.
    [HasCreatingProductPermission], [HasReadingProductPermission], [HasUpdatingProductPermission], [HasDeletingProductPermission],
    -- ProductSet CRUD Permissions.
    [HasCreatingProductSetPermission], [HasReadingProductSetPermission], [HasUpdatingProductSetPermission], [HasDeletingProductSetPermission],
    -- Job CRUD Permissions.
    [HasCreatingJobPermission], [HasReadingJobPermission], [HasUpdatingJobPermission], [HasDeletingJobPermission],
    -- Vendor CRUD Permissions.
    [HasCreatingVendorPermission], [HasReadingVendorPermission], [HasUpdatingVendorPermission], [HasDeletingVendorPermission]
)
OUTPUT INSERTED.Id
INTO #RoleIdTable
VALUES
(
    -- Non-nullable columns.
    @RoleName,
    -- Permissions.
    -- Asset CRUD Permissions.
    1, 1, 1, 1,
    -- Building CRUD Permissions.
    1, 1, 1, 1,
    -- Category CRUD Permissions.
    1, 1, 1, 1,
    -- Company CRUD Permissions.
    1, 1, 1, 1,
    -- Department CRUD Permissions.
    1, 1, 1, 1,
    -- Employee CRUD Permissions.
    1, 1, 1, 1,
    -- EndUser CRUD Permissions.
    1, 1, 1, 1,
    -- Role CRUD Permissions.
    1, 1, 1, 1,
    -- Location CRUD Permissions.
    1, 1, 1, 1,
    -- Log R Permissions.
    1,
    -- Manufacturer CRUD Permissions.
    1, 1, 1, 1,
    -- Product CRUD Permissions.
    1, 1, 1, 1,
    -- ProductSet CRUD Permissions.
    1, 1, 1, 1,
    -- Job CRUD Permissions.
    1, 1, 1, 1,
    -- Vendor CRUD Permissions.
    1, 1, 1, 1
);

SET @RoleId = (SELECT RoleId FROM #RoleIdTable);
DROP TABLE #RoleIdTable;

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
