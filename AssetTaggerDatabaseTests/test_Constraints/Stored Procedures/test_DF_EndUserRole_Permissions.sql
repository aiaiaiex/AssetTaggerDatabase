CREATE PROCEDURE [test_Constraints].[test_DF_EndUserRole_Permissions]
AS
BEGIN
    -- Create dummy data for EndUserRole.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[EndUserRole]', @Defaults = 1;

    DECLARE @EndUserRoleID UNIQUEIDENTIFIER = NEWID();
    DECLARE @EndUserRoleName NVARCHAR(4000) = 'End User Role Name 01';

    INSERT INTO [dbo].[EndUserRole] (EndUserRoleID, EndUserRoleName) VALUES
    (@EndUserRoleID, @EndUserRoleName);

    -- Expected ouput.
    CREATE TABLE #expected (
        [EndUserRoleID] UNIQUEIDENTIFIER,
        [EndUserRoleName] NVARCHAR(4000),
        -- Asset Permissions
        [CreateAsset] BIT,
        [ReadAsset] BIT,
        [UpdateAsset] BIT,
        [DeleteAsset] BIT,
        -- AssetFix Permissions
        [CreateAssetFix] BIT,
        [ReadAssetFix] BIT,
        [UpdateAssetFix] BIT,
        [DeleteAssetFix] BIT,
        -- AssetIssue Permissions
        [CreateAssetIssue] BIT,
        [ReadAssetIssue] BIT,
        [UpdateAssetIssue] BIT,
        [DeleteAssetIssue] BIT,
        -- AssetTransfer Permissions
        [CreateAssetTransfer] BIT,
        [ReadAssetTransfer] BIT,
        [UpdateAssetTransfer] BIT,
        [DeleteAssetTransfer] BIT,
        -- Building Permissions
        [CreateBuilding] BIT,
        [ReadBuilding] BIT,
        [UpdateBuilding] BIT,
        [DeleteBuilding] BIT,
        -- Category Permissions
        [CreateCategory] BIT,
        [ReadCategory] BIT,
        [UpdateCategory] BIT,
        [DeleteCategory] BIT,
        -- Company Permissions
        [CreateCompany] BIT,
        [ReadCompany] BIT,
        [UpdateCompany] BIT,
        [DeleteCompany] BIT,
        -- Department Permissions
        [CreateDepartment] BIT,
        [ReadDepartment] BIT,
        [UpdateDepartment] BIT,
        [DeleteDepartment] BIT,
        -- Employee Permissions
        [CreateEmployee] BIT,
        [ReadEmployee] BIT,
        [UpdateEmployee] BIT,
        [DeleteEmployee] BIT,
        -- EndUser Permissions
        [CreateEndUser] BIT,
        [ReadEndUser] BIT,
        [UpdateEndUser] BIT,
        [DeleteEndUser] BIT,
        -- EndUserRole Permissions
        [CreateEndUserRole] BIT,
        [ReadEndUserRole] BIT,
        [UpdateEndUserRole] BIT,
        [DeleteEndUserRole] BIT,
        -- Location Permissions
        [CreateLocation] BIT,
        [ReadLocation] BIT,
        [UpdateLocation] BIT,
        [DeleteLocation] BIT,
        -- Manufacturer Permissions
        [CreateManufacturer] BIT,
        [ReadManufacturer] BIT,
        [UpdateManufacturer] BIT,
        [DeleteManufacturer] BIT,
        -- Product Permissions
        [CreateProduct] BIT,
        [ReadProduct] BIT,
        [UpdateProduct] BIT,
        [DeleteProduct] BIT,
        -- ProductSet Permissions
        [CreateProductSet] BIT,
        [ReadProductSet] BIT,
        [UpdateProductSet] BIT,
        [DeleteProductSet] BIT,
        -- Role Permissions
        [CreateRole] BIT,
        [ReadRole] BIT,
        [UpdateRole] BIT,
        [DeleteRole] BIT,
        -- Vendor Permissions
        [CreateVendor] BIT,
        [ReadVendor] BIT,
        [UpdateVendor] BIT,
        [DeleteVendor] BIT
    );

    INSERT INTO #expected VALUES (@EndUserRoleID, @EndUserRoleName, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

    -- Actual ouput.
    CREATE TABLE #actual (
        [EndUserRoleID] UNIQUEIDENTIFIER,
        [EndUserRoleName] NVARCHAR(4000),
        -- Asset Permissions
        [CreateAsset] BIT,
        [ReadAsset] BIT,
        [UpdateAsset] BIT,
        [DeleteAsset] BIT,
        -- AssetFix Permissions
        [CreateAssetFix] BIT,
        [ReadAssetFix] BIT,
        [UpdateAssetFix] BIT,
        [DeleteAssetFix] BIT,
        -- AssetIssue Permissions
        [CreateAssetIssue] BIT,
        [ReadAssetIssue] BIT,
        [UpdateAssetIssue] BIT,
        [DeleteAssetIssue] BIT,
        -- AssetTransfer Permissions
        [CreateAssetTransfer] BIT,
        [ReadAssetTransfer] BIT,
        [UpdateAssetTransfer] BIT,
        [DeleteAssetTransfer] BIT,
        -- Building Permissions
        [CreateBuilding] BIT,
        [ReadBuilding] BIT,
        [UpdateBuilding] BIT,
        [DeleteBuilding] BIT,
        -- Category Permissions
        [CreateCategory] BIT,
        [ReadCategory] BIT,
        [UpdateCategory] BIT,
        [DeleteCategory] BIT,
        -- Company Permissions
        [CreateCompany] BIT,
        [ReadCompany] BIT,
        [UpdateCompany] BIT,
        [DeleteCompany] BIT,
        -- Department Permissions
        [CreateDepartment] BIT,
        [ReadDepartment] BIT,
        [UpdateDepartment] BIT,
        [DeleteDepartment] BIT,
        -- Employee Permissions
        [CreateEmployee] BIT,
        [ReadEmployee] BIT,
        [UpdateEmployee] BIT,
        [DeleteEmployee] BIT,
        -- EndUser Permissions
        [CreateEndUser] BIT,
        [ReadEndUser] BIT,
        [UpdateEndUser] BIT,
        [DeleteEndUser] BIT,
        -- EndUserRole Permissions
        [CreateEndUserRole] BIT,
        [ReadEndUserRole] BIT,
        [UpdateEndUserRole] BIT,
        [DeleteEndUserRole] BIT,
        -- Location Permissions
        [CreateLocation] BIT,
        [ReadLocation] BIT,
        [UpdateLocation] BIT,
        [DeleteLocation] BIT,
        -- Manufacturer Permissions
        [CreateManufacturer] BIT,
        [ReadManufacturer] BIT,
        [UpdateManufacturer] BIT,
        [DeleteManufacturer] BIT,
        -- Product Permissions
        [CreateProduct] BIT,
        [ReadProduct] BIT,
        [UpdateProduct] BIT,
        [DeleteProduct] BIT,
        -- ProductSet Permissions
        [CreateProductSet] BIT,
        [ReadProductSet] BIT,
        [UpdateProductSet] BIT,
        [DeleteProductSet] BIT,
        -- Role Permissions
        [CreateRole] BIT,
        [ReadRole] BIT,
        [UpdateRole] BIT,
        [DeleteRole] BIT,
        -- Vendor Permissions
        [CreateVendor] BIT,
        [ReadVendor] BIT,
        [UpdateVendor] BIT,
        [DeleteVendor] BIT
    );

    INSERT INTO #actual
    SELECT * FROM [dbo].[EndUserRole];

    -- Check if default value is not null.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
