CREATE TABLE [dbo].[EndUserRole] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_EndUserRole_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_EndUserRole_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_EndUserRole] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_EndUserRole_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Asset CRUD Permissions.
    [HasCreatingAssetPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingAssetPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingAssetPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingAssetPermission] BIT DEFAULT 0 NOT NULL,
    -- Building CRUD Permissions.
    [HasCreatingBuildingPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingBuildingPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingBuildingPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingBuildingPermission] BIT DEFAULT 0 NOT NULL,
    -- Category CRUD Permissions.
    [HasCreatingCategoryPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingCategoryPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingCategoryPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingCategoryPermission] BIT DEFAULT 0 NOT NULL,
    -- Company CRUD Permissions.
    [HasCreatingCompanyPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingCompanyPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingCompanyPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingCompanyPermission] BIT DEFAULT 0 NOT NULL,
    -- Department CRUD Permissions.
    [HasCreatingDepartmentPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingDepartmentPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingDepartmentPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingDepartmentPermission] BIT DEFAULT 0 NOT NULL,
    -- Employee CRUD Permissions.
    [HasCreatingEmployeePermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingEmployeePermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingEmployeePermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingEmployeePermission] BIT DEFAULT 0 NOT NULL,
    -- EndUser CRUD Permissions.
    [HasCreatingEndUserPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingEndUserPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingEndUserPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingEndUserPermission] BIT DEFAULT 0 NOT NULL,
    -- EndUserRole CRUD Permissions.
    [HasCreatingEndUserRolePermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingEndUserRolePermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingEndUserRolePermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingEndUserRolePermission] BIT DEFAULT 0 NOT NULL,
    -- Location CRUD Permissions.
    [HasCreatingLocationPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingLocationPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingLocationPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingLocationPermission] BIT DEFAULT 0 NOT NULL,
    -- Manufacturer CRUD Permissions.
    [HasCreatingManufacturerPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingManufacturerPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingManufacturerPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingManufacturerPermission] BIT DEFAULT 0 NOT NULL,
    -- Product CRUD Permissions.
    [HasCreatingProductPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingProductPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingProductPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingProductPermission] BIT DEFAULT 0 NOT NULL,
    -- ProductSet CRUD Permissions.
    [HasCreatingProductSetPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingProductSetPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingProductSetPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingProductSetPermission] BIT DEFAULT 0 NOT NULL,
    -- Role CRUD Permissions.
    [HasCreatingRolePermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingRolePermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingRolePermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingRolePermission] BIT DEFAULT 0 NOT NULL,
    -- StoredProcedureLog RD Permissions.
    -- StoredProcedureLog has no create permission because every call to stored procedures should be logged even if CallingEndUserId doesn't exist.
    -- StoredProcedureLog has no update and delete permissions because no update and delete stored procedures for StoredProcedureLog exist to make logs immutable.
    [HasReadingStoredProcedureLogPermission] BIT DEFAULT 0 NOT NULL,
    -- Vendor CRUD Permissions.
    [HasCreatingVendorPermission] BIT DEFAULT 0 NOT NULL,
    [HasReadingVendorPermission] BIT DEFAULT 0 NOT NULL,
    [HasUpdatingVendorPermission] BIT DEFAULT 0 NOT NULL,
    [HasDeletingVendorPermission] BIT DEFAULT 0 NOT NULL,

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_EndUserRole_Name] UNIQUE NONCLUSTERED ([Name] ASC),
    CONSTRAINT [CK_EndUserRole_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Name]) = 1),
    CONSTRAINT [CK_EndUserRole_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Name]) = 1)
);
