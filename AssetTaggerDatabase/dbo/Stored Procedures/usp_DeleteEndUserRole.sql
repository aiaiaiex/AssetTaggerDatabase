CREATE PROCEDURE [dbo].[usp_DeleteEndUserRole]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'EndUserRole';

    -- Run actual query.
    DELETE [dbo].[EndUserRole]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable columns.
        DELETED.Name,
        -- Permissions.
        -- Asset CRUD Permissions.
        DELETED.HasCreatingAssetPermission,
        DELETED.HasReadingAssetPermission,
        DELETED.HasUpdatingAssetPermission,
        DELETED.HasDeletingAssetPermission,
        -- Building CRUD Permissions.
        DELETED.HasCreatingBuildingPermission,
        DELETED.HasReadingBuildingPermission,
        DELETED.HasUpdatingBuildingPermission,
        DELETED.HasDeletingBuildingPermission,
        -- Category CRUD Permissions.
        DELETED.HasCreatingCategoryPermission,
        DELETED.HasReadingCategoryPermission,
        DELETED.HasUpdatingCategoryPermission,
        DELETED.HasDeletingCategoryPermission,
        -- Company CRUD Permissions.
        DELETED.HasCreatingCompanyPermission,
        DELETED.HasReadingCompanyPermission,
        DELETED.HasUpdatingCompanyPermission,
        DELETED.HasDeletingCompanyPermission,
        -- Department CRUD Permissions.
        DELETED.HasCreatingDepartmentPermission,
        DELETED.HasReadingDepartmentPermission,
        DELETED.HasUpdatingDepartmentPermission,
        DELETED.HasDeletingDepartmentPermission,
        -- Employee CRUD Permissions.
        DELETED.HasCreatingEmployeePermission,
        DELETED.HasReadingEmployeePermission,
        DELETED.HasUpdatingEmployeePermission,
        DELETED.HasDeletingEmployeePermission,
        -- EndUser CRUD Permissions.
        DELETED.HasCreatingEndUserPermission,
        DELETED.HasReadingEndUserPermission,
        DELETED.HasUpdatingEndUserPermission,
        DELETED.HasDeletingEndUserPermission,
        -- EndUserRole CRUD Permissions.
        DELETED.HasCreatingEndUserRolePermission,
        DELETED.HasReadingEndUserRolePermission,
        DELETED.HasUpdatingEndUserRolePermission,
        DELETED.HasDeletingEndUserRolePermission,
        -- Location CRUD Permissions.
        DELETED.HasCreatingLocationPermission,
        DELETED.HasReadingLocationPermission,
        DELETED.HasUpdatingLocationPermission,
        DELETED.HasDeletingLocationPermission,
        -- Manufacturer CRUD Permissions.
        DELETED.HasCreatingManufacturerPermission,
        DELETED.HasReadingManufacturerPermission,
        DELETED.HasUpdatingManufacturerPermission,
        DELETED.HasDeletingManufacturerPermission,
        -- Product CRUD Permissions.
        DELETED.HasCreatingProductPermission,
        DELETED.HasReadingProductPermission,
        DELETED.HasUpdatingProductPermission,
        DELETED.HasDeletingProductPermission,
        -- ProductSet CRUD Permissions.
        DELETED.HasCreatingProductSetPermission,
        DELETED.HasReadingProductSetPermission,
        DELETED.HasUpdatingProductSetPermission,
        DELETED.HasDeletingProductSetPermission,
        -- Role CRUD Permissions.
        DELETED.HasCreatingRolePermission,
        DELETED.HasReadingRolePermission,
        DELETED.HasUpdatingRolePermission,
        DELETED.HasDeletingRolePermission,
        -- StoredProcedureLog R Permissions.
        DELETED.HasReadingStoredProcedureLogPermission,
        -- Vendor CRUD Permissions.
        DELETED.HasCreatingVendorPermission,
        DELETED.HasReadingVendorPermission,
        DELETED.HasUpdatingVendorPermission,
        DELETED.HasDeletingVendorPermission
    FROM
        [dbo].[EndUserRole]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
