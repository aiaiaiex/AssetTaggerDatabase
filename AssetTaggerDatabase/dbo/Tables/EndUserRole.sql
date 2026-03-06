CREATE TABLE [dbo].[EndUserRole] (
    [EndUserRoleID] UNIQUEIDENTIFIER CONSTRAINT [DF_EndUserRole_EndUserRoleID] DEFAULT (NEWID()) NOT NULL,
    [EndUserRoleName] NVARCHAR(50) NOT NULL,
    -- Asset Permissions
    [CreateAsset] BIT DEFAULT 0 NOT NULL,
    [ReadAsset] BIT DEFAULT 0 NOT NULL,
    [UpdateAsset] BIT DEFAULT 0 NOT NULL,
    [DeleteAsset] BIT DEFAULT 0 NOT NULL,
    -- AssetFix Permissions
    [CreateAssetFix] BIT DEFAULT 0 NOT NULL,
    [ReadAssetFix] BIT DEFAULT 0 NOT NULL,
    [UpdateAssetFix] BIT DEFAULT 0 NOT NULL,
    [DeleteAssetFix] BIT DEFAULT 0 NOT NULL,
    -- AssetIssue Permissions
    [CreateAssetIssue] BIT DEFAULT 0 NOT NULL,
    [ReadAssetIssue] BIT DEFAULT 0 NOT NULL,
    [UpdateAssetIssue] BIT DEFAULT 0 NOT NULL,
    [DeleteAssetIssue] BIT DEFAULT 0 NOT NULL,
    -- AssetTransfer Permissions
    [CreateAssetTransfer] BIT DEFAULT 0 NOT NULL,
    [ReadAssetTransfer] BIT DEFAULT 0 NOT NULL,
    [UpdateAssetTransfer] BIT DEFAULT 0 NOT NULL,
    [DeleteAssetTransfer] BIT DEFAULT 0 NOT NULL,
    -- Building Permissions
    [CreateBuilding] BIT DEFAULT 0 NOT NULL,
    [ReadBuilding] BIT DEFAULT 0 NOT NULL,
    [UpdateBuilding] BIT DEFAULT 0 NOT NULL,
    [DeleteBuilding] BIT DEFAULT 0 NOT NULL,
    -- Category Permissions
    [CreateCategory] BIT DEFAULT 0 NOT NULL,
    [ReadCategory] BIT DEFAULT 0 NOT NULL,
    [UpdateCategory] BIT DEFAULT 0 NOT NULL,
    [DeleteCategory] BIT DEFAULT 0 NOT NULL,
    -- Company Permissions
    [CreateCompany] BIT DEFAULT 0 NOT NULL,
    [ReadCompany] BIT DEFAULT 0 NOT NULL,
    [UpdateCompany] BIT DEFAULT 0 NOT NULL,
    [DeleteCompany] BIT DEFAULT 0 NOT NULL,
    -- Department Permissions
    [CreateDepartment] BIT DEFAULT 0 NOT NULL,
    [ReadDepartment] BIT DEFAULT 0 NOT NULL,
    [UpdateDepartment] BIT DEFAULT 0 NOT NULL,
    [DeleteDepartment] BIT DEFAULT 0 NOT NULL,
    -- Employee Permissions
    [CreateEmployee] BIT DEFAULT 0 NOT NULL,
    [ReadEmployee] BIT DEFAULT 0 NOT NULL,
    [UpdateEmployee] BIT DEFAULT 0 NOT NULL,
    [DeleteEmployee] BIT DEFAULT 0 NOT NULL,
    -- EndUser Permissions
    [CreateEndUser] BIT DEFAULT 0 NOT NULL,
    [ReadEndUser] BIT DEFAULT 0 NOT NULL,
    [UpdateEndUser] BIT DEFAULT 0 NOT NULL,
    [DeleteEndUser] BIT DEFAULT 0 NOT NULL,
    -- EndUserRole Permissions
    [CreateEndUserRole] BIT DEFAULT 0 NOT NULL,
    [ReadEndUserRole] BIT DEFAULT 0 NOT NULL,
    [UpdateEndUserRole] BIT DEFAULT 0 NOT NULL,
    [DeleteEndUserRole] BIT DEFAULT 0 NOT NULL,
    -- Location Permissions
    [CreateLocation] BIT DEFAULT 0 NOT NULL,
    [ReadLocation] BIT DEFAULT 0 NOT NULL,
    [UpdateLocation] BIT DEFAULT 0 NOT NULL,
    [DeleteLocation] BIT DEFAULT 0 NOT NULL,
    -- Manufacturer Permissions
    [CreateManufacturer] BIT DEFAULT 0 NOT NULL,
    [ReadManufacturer] BIT DEFAULT 0 NOT NULL,
    [UpdateManufacturer] BIT DEFAULT 0 NOT NULL,
    [DeleteManufacturer] BIT DEFAULT 0 NOT NULL,
    -- Product Permissions
    [CreateProduct] BIT DEFAULT 0 NOT NULL,
    [ReadProduct] BIT DEFAULT 0 NOT NULL,
    [UpdateProduct] BIT DEFAULT 0 NOT NULL,
    [DeleteProduct] BIT DEFAULT 0 NOT NULL,
    -- ProductSet Permissions
    [CreateProductSet] BIT DEFAULT 0 NOT NULL,
    [ReadProductSet] BIT DEFAULT 0 NOT NULL,
    [UpdateProductSet] BIT DEFAULT 0 NOT NULL,
    [DeleteProductSet] BIT DEFAULT 0 NOT NULL,
    -- Role Permissions
    [CreateRole] BIT DEFAULT 0 NOT NULL,
    [ReadRole] BIT DEFAULT 0 NOT NULL,
    [UpdateRole] BIT DEFAULT 0 NOT NULL,
    [DeleteRole] BIT DEFAULT 0 NOT NULL,
    -- Vendor Permissions
    [CreateVendor] BIT DEFAULT 0 NOT NULL,
    [ReadVendor] BIT DEFAULT 0 NOT NULL,
    [UpdateVendor] BIT DEFAULT 0 NOT NULL,
    [DeleteVendor] BIT DEFAULT 0 NOT NULL,
    -- Constraints
    CONSTRAINT [PK_EndUserRole] PRIMARY KEY CLUSTERED ([EndUserRoleID] ASC),
    CONSTRAINT [AK_EndUserRole_EndUserRoleName] UNIQUE NONCLUSTERED ([EndUserRoleName] ASC)
);
