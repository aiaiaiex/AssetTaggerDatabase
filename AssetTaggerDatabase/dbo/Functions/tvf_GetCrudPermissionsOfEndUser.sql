CREATE FUNCTION [dbo].[tvf_GetCrudPermissionsOfEndUser](
    @Id UNIQUEIDENTIFIER
)
RETURNS TABLE WITH SCHEMABINDING AS
RETURN SELECT
    -- Asset CRUD Permissions
    EndUserRole.HasCreatingAssetPermission,
    EndUserRole.HasReadingAssetPermission,
    EndUserRole.HasUpdatingAssetPermission,
    EndUserRole.HasDeletingAssetPermission,
    -- Building CRUD Permissions
    EndUserRole.HasCreatingBuildingPermission,
    EndUserRole.HasReadingBuildingPermission,
    EndUserRole.HasUpdatingBuildingPermission,
    EndUserRole.HasDeletingBuildingPermission,
    -- Category CRUD Permissions
    EndUserRole.HasCreatingCategoryPermission,
    EndUserRole.HasReadingCategoryPermission,
    EndUserRole.HasUpdatingCategoryPermission,
    EndUserRole.HasDeletingCategoryPermission,
    -- Company CRUD Permissions
    EndUserRole.HasCreatingCompanyPermission,
    EndUserRole.HasReadingCompanyPermission,
    EndUserRole.HasUpdatingCompanyPermission,
    EndUserRole.HasDeletingCompanyPermission,
    -- Department CRUD Permissions
    EndUserRole.HasCreatingDepartmentPermission,
    EndUserRole.HasReadingDepartmentPermission,
    EndUserRole.HasUpdatingDepartmentPermission,
    EndUserRole.HasDeletingDepartmentPermission,
    -- Employee CRUD Permissions
    EndUserRole.HasCreatingEmployeePermission,
    EndUserRole.HasReadingEmployeePermission,
    EndUserRole.HasUpdatingEmployeePermission,
    EndUserRole.HasDeletingEmployeePermission,
    -- EndUser CRUD Permissions
    EndUserRole.HasCreatingEndUserPermission,
    EndUserRole.HasReadingEndUserPermission,
    EndUserRole.HasUpdatingEndUserPermission,
    EndUserRole.HasDeletingEndUserPermission,
    -- EndUserRole CRUD Permissions
    EndUserRole.HasCreatingEndUserRolePermission,
    EndUserRole.HasReadingEndUserRolePermission,
    EndUserRole.HasUpdatingEndUserRolePermission,
    EndUserRole.HasDeletingEndUserRolePermission,
    -- Location CRUD Permissions
    EndUserRole.HasCreatingLocationPermission,
    EndUserRole.HasReadingLocationPermission,
    EndUserRole.HasUpdatingLocationPermission,
    EndUserRole.HasDeletingLocationPermission,
    -- Log RD Permissions
    EndUserRole.HasReadingStoredProcedureLogPermission,
    EndUserRole.HasDeletingStoredProcedureLogPermission,
    -- Manufacturer CRUD Permissions
    EndUserRole.HasCreatingManufacturerPermission,
    EndUserRole.HasReadingManufacturerPermission,
    EndUserRole.HasUpdatingManufacturerPermission,
    EndUserRole.HasDeletingManufacturerPermission,
    -- Product CRUD Permissions
    EndUserRole.HasCreatingProductPermission,
    EndUserRole.HasReadingProductPermission,
    EndUserRole.HasUpdatingProductPermission,
    EndUserRole.HasDeletingProductPermission,
    -- ProductSet CRUD Permissions
    EndUserRole.HasCreatingProductSetPermission,
    EndUserRole.HasReadingProductSetPermission,
    EndUserRole.HasUpdatingProductSetPermission,
    EndUserRole.HasDeletingProductSetPermission,
    -- Role CRUD Permissions
    EndUserRole.HasCreatingRolePermission,
    EndUserRole.HasReadingRolePermission,
    EndUserRole.HasUpdatingRolePermission,
    EndUserRole.HasDeletingRolePermission,
    -- Vendor CRUD Permissions
    EndUserRole.HasCreatingVendorPermission,
    EndUserRole.HasReadingVendorPermission,
    EndUserRole.HasUpdatingVendorPermission,
    EndUserRole.HasDeletingVendorPermission
FROM
    [dbo].[EndUserRole] AS EndUserRole
INNER JOIN
    [dbo].[EndUser] AS EndUser
    ON EndUserRole.Id = EndUser.EndUserRoleId
WHERE
    EndUser.Id = @Id;
