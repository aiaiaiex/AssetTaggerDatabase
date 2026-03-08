CREATE TABLE [dbo].[EndUserRole] (
    [EndUserRoleID] UNIQUEIDENTIFIER CONSTRAINT [DF_EndUserRole_EndUserRoleID] DEFAULT (NEWID()) NOT NULL,
    [EndUserRoleName] NVARCHAR(50) NOT NULL,
    -- Asset CRUD Permissions
    [CreateAsset] BIT DEFAULT 0 NOT NULL,
    [ReadAsset] BIT DEFAULT 0 NOT NULL,
    [UpdateAsset] BIT DEFAULT 0 NOT NULL,
    [DeleteAsset] BIT DEFAULT 0 NOT NULL,
    -- AssetFix CRUD Permissions
    [CreateAssetFix] BIT DEFAULT 0 NOT NULL,
    [ReadAssetFix] BIT DEFAULT 0 NOT NULL,
    [UpdateAssetFix] BIT DEFAULT 0 NOT NULL,
    [DeleteAssetFix] BIT DEFAULT 0 NOT NULL,
    -- AssetIssue CRUD Permissions
    [CreateAssetIssue] BIT DEFAULT 0 NOT NULL,
    [ReadAssetIssue] BIT DEFAULT 0 NOT NULL,
    [UpdateAssetIssue] BIT DEFAULT 0 NOT NULL,
    [DeleteAssetIssue] BIT DEFAULT 0 NOT NULL,
    -- AssetTransfer CRUD Permissions
    [CreateAssetTransfer] BIT DEFAULT 0 NOT NULL,
    [ReadAssetTransfer] BIT DEFAULT 0 NOT NULL,
    [UpdateAssetTransfer] BIT DEFAULT 0 NOT NULL,
    [DeleteAssetTransfer] BIT DEFAULT 0 NOT NULL,
    -- Building CRUD Permissions
    [CreateBuilding] BIT DEFAULT 0 NOT NULL,
    [ReadBuilding] BIT DEFAULT 0 NOT NULL,
    [UpdateBuilding] BIT DEFAULT 0 NOT NULL,
    [DeleteBuilding] BIT DEFAULT 0 NOT NULL,
    -- Category CRUD Permissions
    [CreateCategory] BIT DEFAULT 0 NOT NULL,
    [ReadCategory] BIT DEFAULT 0 NOT NULL,
    [UpdateCategory] BIT DEFAULT 0 NOT NULL,
    [DeleteCategory] BIT DEFAULT 0 NOT NULL,
    -- Company CRUD Permissions
    [CreateCompany] BIT DEFAULT 0 NOT NULL,
    [ReadCompany] BIT DEFAULT 0 NOT NULL,
    [UpdateCompany] BIT DEFAULT 0 NOT NULL,
    [DeleteCompany] BIT DEFAULT 0 NOT NULL,
    -- Department CRUD Permissions
    [CreateDepartment] BIT DEFAULT 0 NOT NULL,
    [ReadDepartment] BIT DEFAULT 0 NOT NULL,
    [UpdateDepartment] BIT DEFAULT 0 NOT NULL,
    [DeleteDepartment] BIT DEFAULT 0 NOT NULL,
    -- Employee CRUD Permissions
    [CreateEmployee] BIT DEFAULT 0 NOT NULL,
    [ReadEmployee] BIT DEFAULT 0 NOT NULL,
    [UpdateEmployee] BIT DEFAULT 0 NOT NULL,
    [DeleteEmployee] BIT DEFAULT 0 NOT NULL,
    -- EndUser CRUD Permissions
    [CreateEndUser] BIT DEFAULT 0 NOT NULL,
    [ReadEndUser] BIT DEFAULT 0 NOT NULL,
    [UpdateEndUser] BIT DEFAULT 0 NOT NULL,
    [DeleteEndUser] BIT DEFAULT 0 NOT NULL,
    -- EndUserRole CRUD Permissions
    [CreateEndUserRole] BIT DEFAULT 0 NOT NULL,
    [ReadEndUserRole] BIT DEFAULT 0 NOT NULL,
    [UpdateEndUserRole] BIT DEFAULT 0 NOT NULL,
    [DeleteEndUserRole] BIT DEFAULT 0 NOT NULL,
    -- Location CRUD Permissions
    [CreateLocation] BIT DEFAULT 0 NOT NULL,
    [ReadLocation] BIT DEFAULT 0 NOT NULL,
    [UpdateLocation] BIT DEFAULT 0 NOT NULL,
    [DeleteLocation] BIT DEFAULT 0 NOT NULL,
    -- Manufacturer CRUD Permissions
    [CreateManufacturer] BIT DEFAULT 0 NOT NULL,
    [ReadManufacturer] BIT DEFAULT 0 NOT NULL,
    [UpdateManufacturer] BIT DEFAULT 0 NOT NULL,
    [DeleteManufacturer] BIT DEFAULT 0 NOT NULL,
    -- Product CRUD Permissions
    [CreateProduct] BIT DEFAULT 0 NOT NULL,
    [ReadProduct] BIT DEFAULT 0 NOT NULL,
    [UpdateProduct] BIT DEFAULT 0 NOT NULL,
    [DeleteProduct] BIT DEFAULT 0 NOT NULL,
    -- ProductSet CRUD Permissions
    [CreateProductSet] BIT DEFAULT 0 NOT NULL,
    [ReadProductSet] BIT DEFAULT 0 NOT NULL,
    [UpdateProductSet] BIT DEFAULT 0 NOT NULL,
    [DeleteProductSet] BIT DEFAULT 0 NOT NULL,
    -- Role CRUD Permissions
    [CreateRole] BIT DEFAULT 0 NOT NULL,
    [ReadRole] BIT DEFAULT 0 NOT NULL,
    [UpdateRole] BIT DEFAULT 0 NOT NULL,
    [DeleteRole] BIT DEFAULT 0 NOT NULL,
    -- Vendor CRUD Permissions
    [CreateVendor] BIT DEFAULT 0 NOT NULL,
    [ReadVendor] BIT DEFAULT 0 NOT NULL,
    [UpdateVendor] BIT DEFAULT 0 NOT NULL,
    [DeleteVendor] BIT DEFAULT 0 NOT NULL,
    -- Constraints
    CONSTRAINT [PK_EndUserRole] PRIMARY KEY CLUSTERED ([EndUserRoleID] ASC),
    CONSTRAINT [CK_EndUserRole_EndUserRoleName_MinimumLength] CHECK (LEN([EndUserRoleName]) > 0),
    CONSTRAINT [CK_EndUserRole_EndUserRoleName_NoTrailingSpace] CHECK ([EndUserRoleName] NOT LIKE ' %' AND [EndUserRoleName] NOT LIKE '% '),
    CONSTRAINT [AK_EndUserRole_EndUserRoleName] UNIQUE NONCLUSTERED ([EndUserRoleName] ASC)
);
