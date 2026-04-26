CREATE PROCEDURE [dbo].[usp_UpdateEndUserRole]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
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
    -- Job CRUD Permissions.
    @HasCreatingJobPermission NVARCHAR(1) = '',
    @HasReadingJobPermission NVARCHAR(1) = '',
    @HasUpdatingJobPermission NVARCHAR(1) = '',
    @HasDeletingJobPermission NVARCHAR(1) = '',
    -- Log R Permissions.
    @HasReadingLogPermission NVARCHAR(1) = '',
    -- Vendor CRUD Permissions.
    @HasCreatingVendorPermission NVARCHAR(1) = '',
    @HasReadingVendorPermission NVARCHAR(1) = '',
    @HasUpdatingVendorPermission NVARCHAR(1) = '',
    @HasDeletingVendorPermission NVARCHAR(1) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
        -- Non-nullable columns.
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''', ',
        -- Permissions.
        -- Asset CRUD Permissions.
        '@HasCreatingAssetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingAssetPermission), ''', ',
        '@HasReadingAssetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingAssetPermission), ''', ',
        '@HasUpdatingAssetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingAssetPermission), ''', ',
        '@HasDeletingAssetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingAssetPermission), ''', ',
        -- Building CRUD Permissions.
        '@HasCreatingBuildingPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingBuildingPermission), ''', ',
        '@HasReadingBuildingPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingBuildingPermission), ''', ',
        '@HasUpdatingBuildingPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingBuildingPermission), ''', ',
        '@HasDeletingBuildingPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingBuildingPermission), ''', ',
        -- Category CRUD Permissions.
        '@HasCreatingCategoryPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingCategoryPermission), ''', ',
        '@HasReadingCategoryPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingCategoryPermission), ''', ',
        '@HasUpdatingCategoryPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingCategoryPermission), ''', ',
        '@HasDeletingCategoryPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingCategoryPermission), ''', ',
        -- Company CRUD Permissions.
        '@HasCreatingCompanyPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingCompanyPermission), ''', ',
        '@HasReadingCompanyPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingCompanyPermission), ''', ',
        '@HasUpdatingCompanyPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingCompanyPermission), ''', ',
        '@HasDeletingCompanyPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingCompanyPermission), ''', ',
        -- Department CRUD Permissions.
        '@HasCreatingDepartmentPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingDepartmentPermission), ''', ',
        '@HasReadingDepartmentPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingDepartmentPermission), ''', ',
        '@HasUpdatingDepartmentPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingDepartmentPermission), ''', ',
        '@HasDeletingDepartmentPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingDepartmentPermission), ''', ',
        -- Employee CRUD Permissions.
        '@HasCreatingEmployeePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingEmployeePermission), ''', ',
        '@HasReadingEmployeePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingEmployeePermission), ''', ',
        '@HasUpdatingEmployeePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingEmployeePermission), ''', ',
        '@HasDeletingEmployeePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingEmployeePermission), ''', ',
        -- EndUser CRUD Permissions.
        '@HasCreatingEndUserPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingEndUserPermission), ''', ',
        '@HasReadingEndUserPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingEndUserPermission), ''', ',
        '@HasUpdatingEndUserPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingEndUserPermission), ''', ',
        '@HasDeletingEndUserPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingEndUserPermission), ''', ',
        -- EndUserRole CRUD Permissions.
        '@HasCreatingEndUserRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingEndUserRolePermission), ''', ',
        '@HasReadingEndUserRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingEndUserRolePermission), ''', ',
        '@HasUpdatingEndUserRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingEndUserRolePermission), ''', ',
        '@HasDeletingEndUserRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingEndUserRolePermission), ''', ',
        -- Location CRUD Permissions.
        '@HasCreatingLocationPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingLocationPermission), ''', ',
        '@HasReadingLocationPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingLocationPermission), ''', ',
        '@HasUpdatingLocationPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingLocationPermission), ''', ',
        '@HasDeletingLocationPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingLocationPermission), ''', ',
        -- Manufacturer CRUD Permissions.
        '@HasCreatingManufacturerPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingManufacturerPermission), ''', ',
        '@HasReadingManufacturerPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingManufacturerPermission), ''', ',
        '@HasUpdatingManufacturerPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingManufacturerPermission), ''', ',
        '@HasDeletingManufacturerPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingManufacturerPermission), ''', ',
        -- Product CRUD Permissions.
        '@HasCreatingProductPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingProductPermission), ''', ',
        '@HasReadingProductPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingProductPermission), ''', ',
        '@HasUpdatingProductPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingProductPermission), ''', ',
        '@HasDeletingProductPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingProductPermission), ''', ',
        -- ProductSet CRUD Permissions.
        '@HasCreatingProductSetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingProductSetPermission), ''', ',
        '@HasReadingProductSetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingProductSetPermission), ''', ',
        '@HasUpdatingProductSetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingProductSetPermission), ''', ',
        '@HasDeletingProductSetPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingProductSetPermission), ''', ',
        -- Job CRUD Permissions.
        '@HasCreatingJobPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingJobPermission), ''', ',
        '@HasReadingJobPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingJobPermission), ''', ',
        '@HasUpdatingJobPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingJobPermission), ''', ',
        '@HasDeletingJobPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingJobPermission), ''', ',
        -- Log R Permissions.
        '@HasReadingLogPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingLogPermission), ''', ',
        -- Vendor CRUD Permissions.
        '@HasCreatingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingVendorPermission), ''', ',
        '@HasReadingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingVendorPermission), ''', ',
        '@HasUpdatingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingVendorPermission), ''', ',
        '@HasDeletingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingVendorPermission), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Update';
    DECLARE @TableName NVARCHAR(4000) = 'EndUserRole';
    DECLARE @EndUserIpAddress NVARCHAR(4000) = [dbo].[udf_GetDefaultNvarchar](@CallingEndUserIpAddress, NULL);

    DECLARE @EndUserId UNIQUEIDENTIFIER;
    DECLARE @EndedAt DATETIME2(3);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorNumber INT;

    BEGIN TRY
        -- Set final values.
        SET @EndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

        -- Check the permission of the calling EndUser.
        EXEC [dbo].[usp_HasPermission] @EndUserId, @Operation, @TableName;

        -- Run actual query.
        UPDATE
            [dbo].[EndUserRole]
        SET
        -- Non-nullable columns.
            Name = [dbo].[udf_GetDefaultNvarchar](@Name, Name),
            -- Permissions.
            -- Asset CRUD Permissions.
            HasCreatingAssetPermission = [dbo].[udf_GetDefaultBit](@HasCreatingAssetPermission, HasCreatingAssetPermission),
            HasReadingAssetPermission = [dbo].[udf_GetDefaultBit](@HasReadingAssetPermission, HasReadingAssetPermission),
            HasUpdatingAssetPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingAssetPermission, HasUpdatingAssetPermission),
            HasDeletingAssetPermission = [dbo].[udf_GetDefaultBit](@HasDeletingAssetPermission, HasDeletingAssetPermission),
            -- Building CRUD Permissions.
            HasCreatingBuildingPermission = [dbo].[udf_GetDefaultBit](@HasCreatingBuildingPermission, HasCreatingBuildingPermission),
            HasReadingBuildingPermission = [dbo].[udf_GetDefaultBit](@HasReadingBuildingPermission, HasReadingBuildingPermission),
            HasUpdatingBuildingPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingBuildingPermission, HasUpdatingBuildingPermission),
            HasDeletingBuildingPermission = [dbo].[udf_GetDefaultBit](@HasDeletingBuildingPermission, HasDeletingBuildingPermission),
            -- Category CRUD Permissions.
            HasCreatingCategoryPermission = [dbo].[udf_GetDefaultBit](@HasCreatingCategoryPermission, HasCreatingCategoryPermission),
            HasReadingCategoryPermission = [dbo].[udf_GetDefaultBit](@HasReadingCategoryPermission, HasReadingCategoryPermission),
            HasUpdatingCategoryPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingCategoryPermission, HasUpdatingCategoryPermission),
            HasDeletingCategoryPermission = [dbo].[udf_GetDefaultBit](@HasDeletingCategoryPermission, HasDeletingCategoryPermission),
            -- Company CRUD Permissions.
            HasCreatingCompanyPermission = [dbo].[udf_GetDefaultBit](@HasCreatingCompanyPermission, HasCreatingCompanyPermission),
            HasReadingCompanyPermission = [dbo].[udf_GetDefaultBit](@HasReadingCompanyPermission, HasReadingCompanyPermission),
            HasUpdatingCompanyPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingCompanyPermission, HasUpdatingCompanyPermission),
            HasDeletingCompanyPermission = [dbo].[udf_GetDefaultBit](@HasDeletingCompanyPermission, HasDeletingCompanyPermission),
            -- Department CRUD Permissions.
            HasCreatingDepartmentPermission = [dbo].[udf_GetDefaultBit](@HasCreatingDepartmentPermission, HasCreatingDepartmentPermission),
            HasReadingDepartmentPermission = [dbo].[udf_GetDefaultBit](@HasReadingDepartmentPermission, HasReadingDepartmentPermission),
            HasUpdatingDepartmentPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingDepartmentPermission, HasUpdatingDepartmentPermission),
            HasDeletingDepartmentPermission = [dbo].[udf_GetDefaultBit](@HasDeletingDepartmentPermission, HasDeletingDepartmentPermission),
            -- Employee CRUD Permissions.
            HasCreatingEmployeePermission = [dbo].[udf_GetDefaultBit](@HasCreatingEmployeePermission, HasCreatingEmployeePermission),
            HasReadingEmployeePermission = [dbo].[udf_GetDefaultBit](@HasReadingEmployeePermission, HasReadingEmployeePermission),
            HasUpdatingEmployeePermission = [dbo].[udf_GetDefaultBit](@HasUpdatingEmployeePermission, HasUpdatingEmployeePermission),
            HasDeletingEmployeePermission = [dbo].[udf_GetDefaultBit](@HasDeletingEmployeePermission, HasDeletingEmployeePermission),
            -- EndUser CRUD Permissions.
            HasCreatingEndUserPermission = [dbo].[udf_GetDefaultBit](@HasCreatingEndUserPermission, HasCreatingEndUserPermission),
            HasReadingEndUserPermission = [dbo].[udf_GetDefaultBit](@HasReadingEndUserPermission, HasReadingEndUserPermission),
            HasUpdatingEndUserPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingEndUserPermission, HasUpdatingEndUserPermission),
            HasDeletingEndUserPermission = [dbo].[udf_GetDefaultBit](@HasDeletingEndUserPermission, HasDeletingEndUserPermission),
            -- EndUserRole CRUD Permissions.
            HasCreatingEndUserRolePermission = [dbo].[udf_GetDefaultBit](@HasCreatingEndUserRolePermission, HasCreatingEndUserRolePermission),
            HasReadingEndUserRolePermission = [dbo].[udf_GetDefaultBit](@HasReadingEndUserRolePermission, HasReadingEndUserRolePermission),
            HasUpdatingEndUserRolePermission = [dbo].[udf_GetDefaultBit](@HasUpdatingEndUserRolePermission, HasUpdatingEndUserRolePermission),
            HasDeletingEndUserRolePermission = [dbo].[udf_GetDefaultBit](@HasDeletingEndUserRolePermission, HasDeletingEndUserRolePermission),
            -- Location CRUD Permissions.
            HasCreatingLocationPermission = [dbo].[udf_GetDefaultBit](@HasCreatingLocationPermission, HasCreatingLocationPermission),
            HasReadingLocationPermission = [dbo].[udf_GetDefaultBit](@HasReadingLocationPermission, HasReadingLocationPermission),
            HasUpdatingLocationPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingLocationPermission, HasUpdatingLocationPermission),
            HasDeletingLocationPermission = [dbo].[udf_GetDefaultBit](@HasDeletingLocationPermission, HasDeletingLocationPermission),
            -- Manufacturer CRUD Permissions.
            HasCreatingManufacturerPermission = [dbo].[udf_GetDefaultBit](@HasCreatingManufacturerPermission, HasCreatingManufacturerPermission),
            HasReadingManufacturerPermission = [dbo].[udf_GetDefaultBit](@HasReadingManufacturerPermission, HasReadingManufacturerPermission),
            HasUpdatingManufacturerPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingManufacturerPermission, HasUpdatingManufacturerPermission),
            HasDeletingManufacturerPermission = [dbo].[udf_GetDefaultBit](@HasDeletingManufacturerPermission, HasDeletingManufacturerPermission),
            -- Product CRUD Permissions.
            HasCreatingProductPermission = [dbo].[udf_GetDefaultBit](@HasCreatingProductPermission, HasCreatingProductPermission),
            HasReadingProductPermission = [dbo].[udf_GetDefaultBit](@HasReadingProductPermission, HasReadingProductPermission),
            HasUpdatingProductPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingProductPermission, HasUpdatingProductPermission),
            HasDeletingProductPermission = [dbo].[udf_GetDefaultBit](@HasDeletingProductPermission, HasDeletingProductPermission),
            -- ProductSet CRUD Permissions.
            HasCreatingProductSetPermission = [dbo].[udf_GetDefaultBit](@HasCreatingProductSetPermission, HasCreatingProductSetPermission),
            HasReadingProductSetPermission = [dbo].[udf_GetDefaultBit](@HasReadingProductSetPermission, HasReadingProductSetPermission),
            HasUpdatingProductSetPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingProductSetPermission, HasUpdatingProductSetPermission),
            HasDeletingProductSetPermission = [dbo].[udf_GetDefaultBit](@HasDeletingProductSetPermission, HasDeletingProductSetPermission),
            -- Job CRUD Permissions.
            HasCreatingJobPermission = [dbo].[udf_GetDefaultBit](@HasCreatingJobPermission, HasCreatingJobPermission),
            HasReadingJobPermission = [dbo].[udf_GetDefaultBit](@HasReadingJobPermission, HasReadingJobPermission),
            HasUpdatingJobPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingJobPermission, HasUpdatingJobPermission),
            HasDeletingJobPermission = [dbo].[udf_GetDefaultBit](@HasDeletingJobPermission, HasDeletingJobPermission),
            -- Log CRUD Permissions.
            HasReadingLogPermission = [dbo].[udf_GetDefaultBit](@HasReadingLogPermission, HasReadingLogPermission),
            -- Vendor CRUD Permissions.
            HasCreatingVendorPermission = [dbo].[udf_GetDefaultBit](@HasCreatingVendorPermission, HasCreatingVendorPermission),
            HasReadingVendorPermission = [dbo].[udf_GetDefaultBit](@HasReadingVendorPermission, HasReadingVendorPermission),
            HasUpdatingVendorPermission = [dbo].[udf_GetDefaultBit](@HasUpdatingVendorPermission, HasUpdatingVendorPermission),
            HasDeletingVendorPermission = [dbo].[udf_GetDefaultBit](@HasDeletingVendorPermission, HasDeletingVendorPermission)
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
            -- Job CRUD Permissions.
            INSERTED.HasCreatingJobPermission,
            INSERTED.HasReadingJobPermission,
            INSERTED.HasUpdatingJobPermission,
            INSERTED.HasDeletingJobPermission,
            -- Log R Permissions.
            INSERTED.HasReadingLogPermission,
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
            -- Job CRUD Permissions.
            DELETED.HasCreatingJobPermission AS OldHasCreatingJobPermission,
            DELETED.HasReadingJobPermission AS OldHasReadingJobPermission,
            DELETED.HasUpdatingJobPermission AS OldHasUpdatingJobPermission,
            DELETED.HasDeletingJobPermission AS OldHasDeletingJobPermission,
            -- Log R Permissions.
            DELETED.HasReadingLogPermission AS OldHasReadingLogPermission,
            -- Vendor CRUD Permissions.
            DELETED.HasCreatingVendorPermission AS OldHasCreatingVendorPermission,
            DELETED.HasReadingVendorPermission AS OldHasReadingVendorPermission,
            DELETED.HasUpdatingVendorPermission AS OldHasUpdatingVendorPermission,
            DELETED.HasDeletingVendorPermission AS OldHasDeletingVendorPermission
        FROM
            [dbo].[EndUserRole]
        WHERE
            Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
