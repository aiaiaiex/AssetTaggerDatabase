CREATE FUNCTION [dbo].[tvf_GetCRUDPermissionsOfEndUser](
    @EndUserID UNIQUEIDENTIFIER
)
RETURNS TABLE WITH SCHEMABINDING AS
RETURN SELECT
    -- Asset CRUD Permissions
    EUR.CreateAsset,
    EUR.ReadAsset,
    EUR.UpdateAsset,
    EUR.DeleteAsset,
    -- AssetFix CRUD Permissions
    EUR.CreateAssetFix,
    EUR.ReadAssetFix,
    EUR.UpdateAssetFix,
    EUR.DeleteAssetFix,
    -- AssetIssue CRUD Permissions
    EUR.CreateAssetIssue,
    EUR.ReadAssetIssue,
    EUR.UpdateAssetIssue,
    EUR.DeleteAssetIssue,
    -- AssetTransfer CRUD Permissions
    EUR.CreateAssetTransfer,
    EUR.ReadAssetTransfer,
    EUR.UpdateAssetTransfer,
    EUR.DeleteAssetTransfer,
    -- Building CRUD Permissions
    EUR.CreateBuilding,
    EUR.ReadBuilding,
    EUR.UpdateBuilding,
    EUR.DeleteBuilding,
    -- Category CRUD Permissions
    EUR.CreateCategory,
    EUR.ReadCategory,
    EUR.UpdateCategory,
    EUR.DeleteCategory,
    -- Company CRUD Permissions
    EUR.CreateCompany,
    EUR.ReadCompany,
    EUR.UpdateCompany,
    EUR.DeleteCompany,
    -- Department CRUD Permissions
    EUR.CreateDepartment,
    EUR.ReadDepartment,
    EUR.UpdateDepartment,
    EUR.DeleteDepartment,
    -- Employee CRUD Permissions
    EUR.CreateEmployee,
    EUR.ReadEmployee,
    EUR.UpdateEmployee,
    EUR.DeleteEmployee,
    -- EndUser CRUD Permissions
    EUR.CreateEndUser,
    EUR.ReadEndUser,
    EUR.UpdateEndUser,
    EUR.DeleteEndUser,
    -- EndUserRole CRUD Permissions
    EUR.CreateEndUserRole,
    EUR.ReadEndUserRole,
    EUR.UpdateEndUserRole,
    EUR.DeleteEndUserRole,
    -- Location CRUD Permissions
    EUR.CreateLocation,
    EUR.ReadLocation,
    EUR.UpdateLocation,
    EUR.DeleteLocation,
    -- Log RD Permissions
    EUR.ReadLog,
    EUR.DeleteLog,
    -- Manufacturer CRUD Permissions
    EUR.CreateManufacturer,
    EUR.ReadManufacturer,
    EUR.UpdateManufacturer,
    EUR.DeleteManufacturer,
    -- Product CRUD Permissions
    EUR.CreateProduct,
    EUR.ReadProduct,
    EUR.UpdateProduct,
    EUR.DeleteProduct,
    -- ProductSet CRUD Permissions
    EUR.CreateProductSet,
    EUR.ReadProductSet,
    EUR.UpdateProductSet,
    EUR.DeleteProductSet,
    -- Role CRUD Permissions
    EUR.CreateRole,
    EUR.ReadRole,
    EUR.UpdateRole,
    EUR.DeleteRole,
    -- Vendor CRUD Permissions
    EUR.CreateVendor,
    EUR.ReadVendor,
    EUR.UpdateVendor,
    EUR.DeleteVendor
FROM
    [dbo].[EndUserRole] AS EUR
INNER JOIN
    [dbo].[EndUser] AS EU
    ON EUR.EndUserRoleID = EU.EndUserRoleID
WHERE
    EU.EndUserID = @EndUserID;
