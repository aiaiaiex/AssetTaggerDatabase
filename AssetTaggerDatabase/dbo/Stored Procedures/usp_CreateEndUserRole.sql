CREATE PROCEDURE [dbo].[usp_CreateEndUserRole]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns.
    @Name NVARCHAR(850),
    -- Permissions.
    -- Asset CRUD Permissions.
    @HasCreatingAssetPermission NVARCHAR(1) = '',
    @HasReadingAssetPermission NVARCHAR(1) = '',
    @HasUpdatingAssetPermission NVARCHAR(1) = '',
    @HasDeletingAssetPermission NVARCHAR(1) = '',
    -- Building CRUD Permissions.
    @HasCreatingBuildingPermission NVARCHAR(1) = '',
    @HasReadingBuildingPermission NVARCHAR(1) = '',
    @HasUpdatingBuildingPermission NVARCHAR(1) = '',
    @HasDeletingBuildingPermission NVARCHAR(1) = '',
    -- Category CRUD Permissions.
    @HasCreatingCategoryPermission NVARCHAR(1) = '',
    @HasReadingCategoryPermission NVARCHAR(1) = '',
    @HasUpdatingCategoryPermission NVARCHAR(1) = '',
    @HasDeletingCategoryPermission NVARCHAR(1) = '',
    -- Company CRUD Permissions.
    @HasCreatingCompanyPermission NVARCHAR(1) = '',
    @HasReadingCompanyPermission NVARCHAR(1) = '',
    @HasUpdatingCompanyPermission NVARCHAR(1) = '',
    @HasDeletingCompanyPermission NVARCHAR(1) = '',
    -- Department CRUD Permissions.
    @HasCreatingDepartmentPermission NVARCHAR(1) = '',
    @HasReadingDepartmentPermission NVARCHAR(1) = '',
    @HasUpdatingDepartmentPermission NVARCHAR(1) = '',
    @HasDeletingDepartmentPermission NVARCHAR(1) = '',
    -- Employee CRUD Permissions.
    @HasCreatingEmployeePermission NVARCHAR(1) = '',
    @HasReadingEmployeePermission NVARCHAR(1) = '',
    @HasUpdatingEmployeePermission NVARCHAR(1) = '',
    @HasDeletingEmployeePermission NVARCHAR(1) = '',
    -- EndUser CRUD Permissions.
    @HasCreatingEndUserPermission NVARCHAR(1) = '',
    @HasReadingEndUserPermission NVARCHAR(1) = '',
    @HasUpdatingEndUserPermission NVARCHAR(1) = '',
    @HasDeletingEndUserPermission NVARCHAR(1) = '',
    -- EndUserRole CRUD Permissions.
    @HasCreatingEndUserRolePermission NVARCHAR(1) = '',
    @HasReadingEndUserRolePermission NVARCHAR(1) = '',
    @HasUpdatingEndUserRolePermission NVARCHAR(1) = '',
    @HasDeletingEndUserRolePermission NVARCHAR(1) = '',
    -- Location CRUD Permissions.
    @HasCreatingLocationPermission NVARCHAR(1) = '',
    @HasReadingLocationPermission NVARCHAR(1) = '',
    @HasUpdatingLocationPermission NVARCHAR(1) = '',
    @HasDeletingLocationPermission NVARCHAR(1) = '',
    -- Manufacturer CRUD Permissions.
    @HasCreatingManufacturerPermission NVARCHAR(1) = '',
    @HasReadingManufacturerPermission NVARCHAR(1) = '',
    @HasUpdatingManufacturerPermission NVARCHAR(1) = '',
    @HasDeletingManufacturerPermission NVARCHAR(1) = '',
    -- Product CRUD Permissions.
    @HasCreatingProductPermission NVARCHAR(1) = '',
    @HasReadingProductPermission NVARCHAR(1) = '',
    @HasUpdatingProductPermission NVARCHAR(1) = '',
    @HasDeletingProductPermission NVARCHAR(1) = '',
    -- ProductSet CRUD Permissions.
    @HasCreatingProductSetPermission NVARCHAR(1) = '',
    @HasReadingProductSetPermission NVARCHAR(1) = '',
    @HasUpdatingProductSetPermission NVARCHAR(1) = '',
    @HasDeletingProductSetPermission NVARCHAR(1) = '',
    -- Role CRUD Permissions.
    @HasCreatingRolePermission NVARCHAR(1) = '',
    @HasReadingRolePermission NVARCHAR(1) = '',
    @HasUpdatingRolePermission NVARCHAR(1) = '',
    @HasDeletingRolePermission NVARCHAR(1) = '',
    -- StoredProcedureLog R Permissions.
    @HasReadingStoredProcedureLogPermission NVARCHAR(1) = '',
    -- Vendor CRUD Permissions.
    @HasCreatingVendorPermission NVARCHAR(1) = '',
    @HasReadingVendorPermission NVARCHAR(1) = '',
    @HasUpdatingVendorPermission NVARCHAR(1) = '',
    @HasDeletingVendorPermission NVARCHAR(1) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'EndUserRole';

    -- Run actual query.
    INSERT INTO [dbo].[EndUserRole] (
        -- Non-nullable columns.
        Name,
        -- Permissions.
        -- Asset CRUD Permissions.
        HasCreatingAssetPermission,
        HasReadingAssetPermission,
        HasUpdatingAssetPermission,
        HasDeletingAssetPermission,
        -- Building CRUD Permissions.
        HasCreatingBuildingPermission,
        HasReadingBuildingPermission,
        HasUpdatingBuildingPermission,
        HasDeletingBuildingPermission,
        -- Category CRUD Permissions.
        HasCreatingCategoryPermission,
        HasReadingCategoryPermission,
        HasUpdatingCategoryPermission,
        HasDeletingCategoryPermission,
        -- Company CRUD Permissions.
        HasCreatingCompanyPermission,
        HasReadingCompanyPermission,
        HasUpdatingCompanyPermission,
        HasDeletingCompanyPermission,
        -- Department CRUD Permissions.
        HasCreatingDepartmentPermission,
        HasReadingDepartmentPermission,
        HasUpdatingDepartmentPermission,
        HasDeletingDepartmentPermission,
        -- Employee CRUD Permissions.
        HasCreatingEmployeePermission,
        HasReadingEmployeePermission,
        HasUpdatingEmployeePermission,
        HasDeletingEmployeePermission,
        -- EndUser CRUD Permissions.
        HasCreatingEndUserPermission,
        HasReadingEndUserPermission,
        HasUpdatingEndUserPermission,
        HasDeletingEndUserPermission,
        -- EndUserRole CRUD Permissions.
        HasCreatingEndUserRolePermission,
        HasReadingEndUserRolePermission,
        HasUpdatingEndUserRolePermission,
        HasDeletingEndUserRolePermission,
        -- Location CRUD Permissions.
        HasCreatingLocationPermission,
        HasReadingLocationPermission,
        HasUpdatingLocationPermission,
        HasDeletingLocationPermission,
        -- Manufacturer CRUD Permissions.
        HasCreatingManufacturerPermission,
        HasReadingManufacturerPermission,
        HasUpdatingManufacturerPermission,
        HasDeletingManufacturerPermission,
        -- Product CRUD Permissions.
        HasCreatingProductPermission,
        HasReadingProductPermission,
        HasUpdatingProductPermission,
        HasDeletingProductPermission,
        -- ProductSet CRUD Permissions.
        HasCreatingProductSetPermission,
        HasReadingProductSetPermission,
        HasUpdatingProductSetPermission,
        HasDeletingProductSetPermission,
        -- Role CRUD Permissions.
        HasCreatingRolePermission,
        HasReadingRolePermission,
        HasUpdatingRolePermission,
        HasDeletingRolePermission,
        -- StoredProcedureLog R Permissions.
        HasReadingStoredProcedureLogPermission,
        -- Vendor CRUD Permissions.
        HasCreatingVendorPermission,
        HasReadingVendorPermission,
        HasUpdatingVendorPermission,
        HasDeletingVendorPermission
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable columns.
        INSERTED.Name,
        -- Permissions.
        -- Asset CRUD Permissions.
        INSERTED.HasCreatingAssetPermission,
        INSERTED.HasReadingAssetPermission,
        INSERTED.HasUpdatingAssetPermission,
        INSERTED.HasDeletingAssetPermission,
        -- Building CRUD Permissions.
        INSERTED.HasCreatingBuildingPermission,
        INSERTED.HasReadingBuildingPermission,
        INSERTED.HasUpdatingBuildingPermission,
        INSERTED.HasDeletingBuildingPermission,
        -- Category CRUD Permissions.
        INSERTED.HasCreatingCategoryPermission,
        INSERTED.HasReadingCategoryPermission,
        INSERTED.HasUpdatingCategoryPermission,
        INSERTED.HasDeletingCategoryPermission,
        -- Company CRUD Permissions.
        INSERTED.HasCreatingCompanyPermission,
        INSERTED.HasReadingCompanyPermission,
        INSERTED.HasUpdatingCompanyPermission,
        INSERTED.HasDeletingCompanyPermission,
        -- Department CRUD Permissions.
        INSERTED.HasCreatingDepartmentPermission,
        INSERTED.HasReadingDepartmentPermission,
        INSERTED.HasUpdatingDepartmentPermission,
        INSERTED.HasDeletingDepartmentPermission,
        -- Employee CRUD Permissions.
        INSERTED.HasCreatingEmployeePermission,
        INSERTED.HasReadingEmployeePermission,
        INSERTED.HasUpdatingEmployeePermission,
        INSERTED.HasDeletingEmployeePermission,
        -- EndUser CRUD Permissions.
        INSERTED.HasCreatingEndUserPermission,
        INSERTED.HasReadingEndUserPermission,
        INSERTED.HasUpdatingEndUserPermission,
        INSERTED.HasDeletingEndUserPermission,
        -- EndUserRole CRUD Permissions.
        INSERTED.HasCreatingEndUserRolePermission,
        INSERTED.HasReadingEndUserRolePermission,
        INSERTED.HasUpdatingEndUserRolePermission,
        INSERTED.HasDeletingEndUserRolePermission,
        -- Location CRUD Permissions.
        INSERTED.HasCreatingLocationPermission,
        INSERTED.HasReadingLocationPermission,
        INSERTED.HasUpdatingLocationPermission,
        INSERTED.HasDeletingLocationPermission,
        -- Manufacturer CRUD Permissions.
        INSERTED.HasCreatingManufacturerPermission,
        INSERTED.HasReadingManufacturerPermission,
        INSERTED.HasUpdatingManufacturerPermission,
        INSERTED.HasDeletingManufacturerPermission,
        -- Product CRUD Permissions.
        INSERTED.HasCreatingProductPermission,
        INSERTED.HasReadingProductPermission,
        INSERTED.HasUpdatingProductPermission,
        INSERTED.HasDeletingProductPermission,
        -- ProductSet CRUD Permissions.
        INSERTED.HasCreatingProductSetPermission,
        INSERTED.HasReadingProductSetPermission,
        INSERTED.HasUpdatingProductSetPermission,
        INSERTED.HasDeletingProductSetPermission,
        -- Role CRUD Permissions.
        INSERTED.HasCreatingRolePermission,
        INSERTED.HasReadingRolePermission,
        INSERTED.HasUpdatingRolePermission,
        INSERTED.HasDeletingRolePermission,
        -- StoredProcedureLog R Permissions.
        INSERTED.HasReadingStoredProcedureLogPermission,
        -- Vendor CRUD Permissions.
        INSERTED.HasCreatingVendorPermission,
        INSERTED.HasReadingVendorPermission,
        INSERTED.HasUpdatingVendorPermission,
        INSERTED.HasDeletingVendorPermission
    VALUES (
        -- Non-nullable columns.
        @Name,
        -- Permissions.
        -- Asset CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingAssetPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingAssetPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingAssetPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingAssetPermission),
        -- Building CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingBuildingPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingBuildingPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingBuildingPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingBuildingPermission),
        -- Category CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingCategoryPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingCategoryPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingCategoryPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingCategoryPermission),
        -- Company CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingCompanyPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingCompanyPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingCompanyPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingCompanyPermission),
        -- Department CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingDepartmentPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingDepartmentPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingDepartmentPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingDepartmentPermission),
        -- Employee CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingEmployeePermission),
        [dbo].[udf_GetDefaultBit](@HasReadingEmployeePermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingEmployeePermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingEmployeePermission),
        -- EndUser CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingEndUserPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingEndUserPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingEndUserPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingEndUserPermission),
        -- EndUserRole CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingEndUserRolePermission),
        [dbo].[udf_GetDefaultBit](@HasReadingEndUserRolePermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingEndUserRolePermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingEndUserRolePermission),
        -- Location CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingLocationPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingLocationPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingLocationPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingLocationPermission),
        -- Manufacturer CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingManufacturerPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingManufacturerPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingManufacturerPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingManufacturerPermission),
        -- Product CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingProductPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingProductPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingProductPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingProductPermission),
        -- ProductSet CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingProductSetPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingProductSetPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingProductSetPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingProductSetPermission),
        -- Role CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingRolePermission),
        [dbo].[udf_GetDefaultBit](@HasReadingRolePermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingRolePermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingRolePermission),
        -- StoredProcedureLog R Permissions.
        [dbo].[udf_GetDefaultBit](@HasReadingStoredProcedureLogPermission),
        -- Vendor CRUD Permissions.
        [dbo].[udf_GetDefaultBit](@HasCreatingVendorPermission),
        [dbo].[udf_GetDefaultBit](@HasReadingVendorPermission),
        [dbo].[udf_GetDefaultBit](@HasUpdatingVendorPermission),
        [dbo].[udf_GetDefaultBit](@HasDeletingVendorPermission)
    );
END;
