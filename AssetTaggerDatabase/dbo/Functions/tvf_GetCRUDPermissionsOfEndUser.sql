CREATE FUNCTION [dbo].[tvf_GetCRUDPermissionsOfEndUser](
    @EndUserID UNIQUEIDENTIFIER
)
RETURNS TABLE WITH SCHEMABINDING AS
RETURN SELECT
    -- Asset CRUD Permissions
    EUR.HasCreatingAssetPermission,
    EUR.HasReadingAssetPermission,
    EUR.HasUpdatingAssetPermission,
    EUR.HasDeletingAssetPermission,
    -- AssetFix CRUD Permissions
    EUR.HasCreatingAssetFixPermission,
    EUR.HasReadingAssetFixPermission,
    EUR.HasUpdatingAssetFixPermission,
    EUR.HasDeletingAssetFixPermission,
    -- AssetIssue CRUD Permissions
    EUR.HasCreatingAssetIssuePermission,
    EUR.HasReadingAssetIssuePermission,
    EUR.HasUpdatingAssetIssuePermission,
    EUR.HasDeletingAssetIssuePermission,
    -- Building CRUD Permissions
    EUR.HasCreatingBuildingPermission,
    EUR.HasReadingBuildingPermission,
    EUR.HasUpdatingBuildingPermission,
    EUR.HasDeletingBuildingPermission,
    -- Category CRUD Permissions
    EUR.HasCreatingCategoryPermission,
    EUR.HasReadingCategoryPermission,
    EUR.HasUpdatingCategoryPermission,
    EUR.HasDeletingCategoryPermission,
    -- Company CRUD Permissions
    EUR.HasCreatingCompanyPermission,
    EUR.HasReadingCompanyPermission,
    EUR.HasUpdatingCompanyPermission,
    EUR.HasDeletingCompanyPermission,
    -- Department CRUD Permissions
    EUR.HasCreatingDepartmentPermission,
    EUR.HasReadingDepartmentPermission,
    EUR.HasUpdatingDepartmentPermission,
    EUR.HasDeletingDepartmentPermission,
    -- Employee CRUD Permissions
    EUR.HasCreatingEmployeePermission,
    EUR.HasReadingEmployeePermission,
    EUR.HasUpdatingEmployeePermission,
    EUR.HasDeletingEmployeePermission,
    -- EndUser CRUD Permissions
    EUR.HasCreatingEndUserPermission,
    EUR.HasReadingEndUserPermission,
    EUR.HasUpdatingEndUserPermission,
    EUR.HasDeletingEndUserPermission,
    -- EndUserRole CRUD Permissions
    EUR.HasCreatingEndUserRolePermission,
    EUR.HasReadingEndUserRolePermission,
    EUR.HasUpdatingEndUserRolePermission,
    EUR.HasDeletingEndUserRolePermission,
    -- Location CRUD Permissions
    EUR.HasCreatingLocationPermission,
    EUR.HasReadingLocationPermission,
    EUR.HasUpdatingLocationPermission,
    EUR.HasDeletingLocationPermission,
    -- Log RD Permissions
    EUR.HasReadingLogPermission,
    EUR.HasDeletingLogPermission,
    -- Manufacturer CRUD Permissions
    EUR.HasCreatingManufacturerPermission,
    EUR.HasReadingManufacturerPermission,
    EUR.HasUpdatingManufacturerPermission,
    EUR.HasDeletingManufacturerPermission,
    -- Product CRUD Permissions
    EUR.HasCreatingProductPermission,
    EUR.HasReadingProductPermission,
    EUR.HasUpdatingProductPermission,
    EUR.HasDeletingProductPermission,
    -- ProductSet CRUD Permissions
    EUR.HasCreatingProductSetPermission,
    EUR.HasReadingProductSetPermission,
    EUR.HasUpdatingProductSetPermission,
    EUR.HasDeletingProductSetPermission,
    -- Role CRUD Permissions
    EUR.HasCreatingRolePermission,
    EUR.HasReadingRolePermission,
    EUR.HasUpdatingRolePermission,
    EUR.HasDeletingRolePermission,
    -- Vendor CRUD Permissions
    EUR.HasCreatingVendorPermission,
    EUR.HasReadingVendorPermission,
    EUR.HasUpdatingVendorPermission,
    EUR.HasDeletingVendorPermission
FROM
    [dbo].[EndUserRole] AS EUR
INNER JOIN
    [dbo].[EndUser] AS EU
    ON EUR.Id = EU.EndUserRoleID
WHERE
    EU.EndUserID = @EndUserID;
