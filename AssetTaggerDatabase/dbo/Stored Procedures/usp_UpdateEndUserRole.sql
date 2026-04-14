CREATE PROCEDURE [dbo].[usp_UpdateEndUserRole]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36),
    -- Non-nullable columns.
    @Name NVARCHAR(850) = '',
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
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'EndUserRole';

    -- Run actual query.
    UPDATE
        [dbo].[EndUserRole]
    SET
        -- Non-nullable columns.
        Name = [dbo].[udf_GetNvarcharColumnValue](@Name, Name),
        -- Permissions.
        -- Asset CRUD Permissions.
        HasCreatingAssetPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingAssetPermission, HasCreatingAssetPermission),
        HasReadingAssetPermission = [dbo].[udf_GetBitColumnValue](@HasReadingAssetPermission, HasReadingAssetPermission),
        HasUpdatingAssetPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingAssetPermission, HasUpdatingAssetPermission),
        HasDeletingAssetPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingAssetPermission, HasDeletingAssetPermission),
        -- Building CRUD Permissions.
        HasCreatingBuildingPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingBuildingPermission, HasCreatingBuildingPermission),
        HasReadingBuildingPermission = [dbo].[udf_GetBitColumnValue](@HasReadingBuildingPermission, HasReadingBuildingPermission),
        HasUpdatingBuildingPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingBuildingPermission, HasUpdatingBuildingPermission),
        HasDeletingBuildingPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingBuildingPermission, HasDeletingBuildingPermission),
        -- Category CRUD Permissions.
        HasCreatingCategoryPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingCategoryPermission, HasCreatingCategoryPermission),
        HasReadingCategoryPermission = [dbo].[udf_GetBitColumnValue](@HasReadingCategoryPermission, HasReadingCategoryPermission),
        HasUpdatingCategoryPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingCategoryPermission, HasUpdatingCategoryPermission),
        HasDeletingCategoryPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingCategoryPermission, HasDeletingCategoryPermission),
        -- Company CRUD Permissions.
        HasCreatingCompanyPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingCompanyPermission, HasCreatingCompanyPermission),
        HasReadingCompanyPermission = [dbo].[udf_GetBitColumnValue](@HasReadingCompanyPermission, HasReadingCompanyPermission),
        HasUpdatingCompanyPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingCompanyPermission, HasUpdatingCompanyPermission),
        HasDeletingCompanyPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingCompanyPermission, HasDeletingCompanyPermission),
        -- Department CRUD Permissions.
        HasCreatingDepartmentPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingDepartmentPermission, HasCreatingDepartmentPermission),
        HasReadingDepartmentPermission = [dbo].[udf_GetBitColumnValue](@HasReadingDepartmentPermission, HasReadingDepartmentPermission),
        HasUpdatingDepartmentPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingDepartmentPermission, HasUpdatingDepartmentPermission),
        HasDeletingDepartmentPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingDepartmentPermission, HasDeletingDepartmentPermission),
        -- Employee CRUD Permissions.
        HasCreatingEmployeePermission = [dbo].[udf_GetBitColumnValue](@HasCreatingEmployeePermission, HasCreatingEmployeePermission),
        HasReadingEmployeePermission = [dbo].[udf_GetBitColumnValue](@HasReadingEmployeePermission, HasReadingEmployeePermission),
        HasUpdatingEmployeePermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingEmployeePermission, HasUpdatingEmployeePermission),
        HasDeletingEmployeePermission = [dbo].[udf_GetBitColumnValue](@HasDeletingEmployeePermission, HasDeletingEmployeePermission),
        -- EndUser CRUD Permissions.
        HasCreatingEndUserPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingEndUserPermission, HasCreatingEndUserPermission),
        HasReadingEndUserPermission = [dbo].[udf_GetBitColumnValue](@HasReadingEndUserPermission, HasReadingEndUserPermission),
        HasUpdatingEndUserPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingEndUserPermission, HasUpdatingEndUserPermission),
        HasDeletingEndUserPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingEndUserPermission, HasDeletingEndUserPermission),
        -- EndUserRole CRUD Permissions.
        HasCreatingEndUserRolePermission = [dbo].[udf_GetBitColumnValue](@HasCreatingEndUserRolePermission, HasCreatingEndUserRolePermission),
        HasReadingEndUserRolePermission = [dbo].[udf_GetBitColumnValue](@HasReadingEndUserRolePermission, HasReadingEndUserRolePermission),
        HasUpdatingEndUserRolePermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingEndUserRolePermission, HasUpdatingEndUserRolePermission),
        HasDeletingEndUserRolePermission = [dbo].[udf_GetBitColumnValue](@HasDeletingEndUserRolePermission, HasDeletingEndUserRolePermission),
        -- Location CRUD Permissions.
        HasCreatingLocationPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingLocationPermission, HasCreatingLocationPermission),
        HasReadingLocationPermission = [dbo].[udf_GetBitColumnValue](@HasReadingLocationPermission, HasReadingLocationPermission),
        HasUpdatingLocationPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingLocationPermission, HasUpdatingLocationPermission),
        HasDeletingLocationPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingLocationPermission, HasDeletingLocationPermission),
        -- Manufacturer CRUD Permissions.
        HasCreatingManufacturerPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingManufacturerPermission, HasCreatingManufacturerPermission),
        HasReadingManufacturerPermission = [dbo].[udf_GetBitColumnValue](@HasReadingManufacturerPermission, HasReadingManufacturerPermission),
        HasUpdatingManufacturerPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingManufacturerPermission, HasUpdatingManufacturerPermission),
        HasDeletingManufacturerPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingManufacturerPermission, HasDeletingManufacturerPermission),
        -- Product CRUD Permissions.
        HasCreatingProductPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingProductPermission, HasCreatingProductPermission),
        HasReadingProductPermission = [dbo].[udf_GetBitColumnValue](@HasReadingProductPermission, HasReadingProductPermission),
        HasUpdatingProductPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingProductPermission, HasUpdatingProductPermission),
        HasDeletingProductPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingProductPermission, HasDeletingProductPermission),
        -- ProductSet CRUD Permissions.
        HasCreatingProductSetPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingProductSetPermission, HasCreatingProductSetPermission),
        HasReadingProductSetPermission = [dbo].[udf_GetBitColumnValue](@HasReadingProductSetPermission, HasReadingProductSetPermission),
        HasUpdatingProductSetPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingProductSetPermission, HasUpdatingProductSetPermission),
        HasDeletingProductSetPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingProductSetPermission, HasDeletingProductSetPermission),
        -- Role CRUD Permissions.
        HasCreatingRolePermission = [dbo].[udf_GetBitColumnValue](@HasCreatingRolePermission, HasCreatingRolePermission),
        HasReadingRolePermission = [dbo].[udf_GetBitColumnValue](@HasReadingRolePermission, HasReadingRolePermission),
        HasUpdatingRolePermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingRolePermission, HasUpdatingRolePermission),
        HasDeletingRolePermission = [dbo].[udf_GetBitColumnValue](@HasDeletingRolePermission, HasDeletingRolePermission),
        -- StoredProcedureLog CRUD Permissions.
        HasReadingStoredProcedureLogPermission = [dbo].[udf_GetBitColumnValue](@HasReadingStoredProcedureLogPermission, HasReadingStoredProcedureLogPermission),
        -- Vendor CRUD Permissions.
        HasCreatingVendorPermission = [dbo].[udf_GetBitColumnValue](@HasCreatingVendorPermission, HasCreatingVendorPermission),
        HasReadingVendorPermission = [dbo].[udf_GetBitColumnValue](@HasReadingVendorPermission, HasReadingVendorPermission),
        HasUpdatingVendorPermission = [dbo].[udf_GetBitColumnValue](@HasUpdatingVendorPermission, HasUpdatingVendorPermission),
        HasDeletingVendorPermission = [dbo].[udf_GetBitColumnValue](@HasDeletingVendorPermission, HasDeletingVendorPermission)
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
        INSERTED.HasDeletingVendorPermission,
        -- Old values.
        -- Non-nullable columns.
        DELETED.Name AS OldName,
        -- Permissions.
        -- Asset CRUD Permissions.
        DELETED.HasCreatingAssetPermission AS OldHasCreatingAssetPermission,
        DELETED.HasReadingAssetPermission AS OldHasReadingAssetPermission,
        DELETED.HasUpdatingAssetPermission AS OldHasUpdatingAssetPermission,
        DELETED.HasDeletingAssetPermission AS OldHasDeletingAssetPermission,
        -- Building CRUD Permissions.
        DELETED.HasCreatingBuildingPermission AS OldHasCreatingBuildingPermission,
        DELETED.HasReadingBuildingPermission AS OldHasReadingBuildingPermission,
        DELETED.HasUpdatingBuildingPermission AS OldHasUpdatingBuildingPermission,
        DELETED.HasDeletingBuildingPermission AS OldHasDeletingBuildingPermission,
        -- Category CRUD Permissions.
        DELETED.HasCreatingCategoryPermission AS OldHasCreatingCategoryPermission,
        DELETED.HasReadingCategoryPermission AS OldHasReadingCategoryPermission,
        DELETED.HasUpdatingCategoryPermission AS OldHasUpdatingCategoryPermission,
        DELETED.HasDeletingCategoryPermission AS OldHasDeletingCategoryPermission,
        -- Company CRUD Permissions.
        DELETED.HasCreatingCompanyPermission AS OldHasCreatingCompanyPermission,
        DELETED.HasReadingCompanyPermission AS OldHasReadingCompanyPermission,
        DELETED.HasUpdatingCompanyPermission AS OldHasUpdatingCompanyPermission,
        DELETED.HasDeletingCompanyPermission AS OldHasDeletingCompanyPermission,
        -- Department CRUD Permissions.
        DELETED.HasCreatingDepartmentPermission AS OldHasCreatingDepartmentPermission,
        DELETED.HasReadingDepartmentPermission AS OldHasReadingDepartmentPermission,
        DELETED.HasUpdatingDepartmentPermission AS OldHasUpdatingDepartmentPermission,
        DELETED.HasDeletingDepartmentPermission AS OldHasDeletingDepartmentPermission,
        -- Employee CRUD Permissions.
        DELETED.HasCreatingEmployeePermission AS OldHasCreatingEmployeePermission,
        DELETED.HasReadingEmployeePermission AS OldHasReadingEmployeePermission,
        DELETED.HasUpdatingEmployeePermission AS OldHasUpdatingEmployeePermission,
        DELETED.HasDeletingEmployeePermission AS OldHasDeletingEmployeePermission,
        -- EndUser CRUD Permissions.
        DELETED.HasCreatingEndUserPermission AS OldHasCreatingEndUserPermission,
        DELETED.HasReadingEndUserPermission AS OldHasReadingEndUserPermission,
        DELETED.HasUpdatingEndUserPermission AS OldHasUpdatingEndUserPermission,
        DELETED.HasDeletingEndUserPermission AS OldHasDeletingEndUserPermission,
        -- EndUserRole CRUD Permissions.
        DELETED.HasCreatingEndUserRolePermission AS OldHasCreatingEndUserRolePermission,
        DELETED.HasReadingEndUserRolePermission AS OldHasReadingEndUserRolePermission,
        DELETED.HasUpdatingEndUserRolePermission AS OldHasUpdatingEndUserRolePermission,
        DELETED.HasDeletingEndUserRolePermission AS OldHasDeletingEndUserRolePermission,
        -- Location CRUD Permissions.
        DELETED.HasCreatingLocationPermission AS OldHasCreatingLocationPermission,
        DELETED.HasReadingLocationPermission AS OldHasReadingLocationPermission,
        DELETED.HasUpdatingLocationPermission AS OldHasUpdatingLocationPermission,
        DELETED.HasDeletingLocationPermission AS OldHasDeletingLocationPermission,
        -- Manufacturer CRUD Permissions.
        DELETED.HasCreatingManufacturerPermission AS OldHasCreatingManufacturerPermission,
        DELETED.HasReadingManufacturerPermission AS OldHasReadingManufacturerPermission,
        DELETED.HasUpdatingManufacturerPermission AS OldHasUpdatingManufacturerPermission,
        DELETED.HasDeletingManufacturerPermission AS OldHasDeletingManufacturerPermission,
        -- Product CRUD Permissions.
        DELETED.HasCreatingProductPermission AS OldHasCreatingProductPermission,
        DELETED.HasReadingProductPermission AS OldHasReadingProductPermission,
        DELETED.HasUpdatingProductPermission AS OldHasUpdatingProductPermission,
        DELETED.HasDeletingProductPermission AS OldHasDeletingProductPermission,
        -- ProductSet CRUD Permissions.
        DELETED.HasCreatingProductSetPermission AS OldHasCreatingProductSetPermission,
        DELETED.HasReadingProductSetPermission AS OldHasReadingProductSetPermission,
        DELETED.HasUpdatingProductSetPermission AS OldHasUpdatingProductSetPermission,
        DELETED.HasDeletingProductSetPermission AS OldHasDeletingProductSetPermission,
        -- Role CRUD Permissions.
        DELETED.HasCreatingRolePermission AS OldHasCreatingRolePermission,
        DELETED.HasReadingRolePermission AS OldHasReadingRolePermission,
        DELETED.HasUpdatingRolePermission AS OldHasUpdatingRolePermission,
        DELETED.HasDeletingRolePermission AS OldHasDeletingRolePermission,
        -- StoredProcedureLog R Permissions.
        DELETED.HasReadingStoredProcedureLogPermission AS OldHasReadingStoredProcedureLogPermission,
        -- Vendor CRUD Permissions.
        DELETED.HasCreatingVendorPermission AS OldHasCreatingVendorPermission,
        DELETED.HasReadingVendorPermission AS OldHasReadingVendorPermission,
        DELETED.HasUpdatingVendorPermission AS OldHasUpdatingVendorPermission,
        DELETED.HasDeletingVendorPermission AS OldHasDeletingVendorPermission
    FROM
        [dbo].[EndUserRole]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
