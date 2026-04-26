CREATE PROCEDURE [dbo].[usp_CreateRole]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
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
    -- Role CRUD Permissions.
    @HasCreatingRolePermission NVARCHAR(1) = '',
    @HasReadingRolePermission NVARCHAR(1) = '',
    @HasUpdatingRolePermission NVARCHAR(1) = '',
    @HasDeletingRolePermission NVARCHAR(1) = '',
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
        -- Role CRUD Permissions.
        '@HasCreatingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingRolePermission), ''', ',
        '@HasReadingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingRolePermission), ''', ',
        '@HasUpdatingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingRolePermission), ''', ',
        '@HasDeletingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingRolePermission), ''', ',
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
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(4000) = 'Role';
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
        INSERT INTO [dbo].[Role] (
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
            -- Role CRUD Permissions.
            HasCreatingRolePermission,
            HasReadingRolePermission,
            HasUpdatingRolePermission,
            HasDeletingRolePermission,
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
            -- Job CRUD Permissions.
            HasCreatingJobPermission,
            HasReadingJobPermission,
            HasUpdatingJobPermission,
            HasDeletingJobPermission,
            -- Log R Permissions.
            HasReadingLogPermission,
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
            -- Role CRUD Permissions.
            INSERTED.HasCreatingRolePermission,
            INSERTED.HasReadingRolePermission,
            INSERTED.HasUpdatingRolePermission,
            INSERTED.HasDeletingRolePermission,
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
            INSERTED.HasDeletingVendorPermission
        VALUES (
        -- Non-nullable columns.
            @Name,
            -- Permissions.
            -- Asset CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingAssetPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingAssetPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingAssetPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingAssetPermission, 0),
            -- Building CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingBuildingPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingBuildingPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingBuildingPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingBuildingPermission, 0),
            -- Category CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingCategoryPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingCategoryPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingCategoryPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingCategoryPermission, 0),
            -- Company CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingCompanyPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingCompanyPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingCompanyPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingCompanyPermission, 0),
            -- Department CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingDepartmentPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingDepartmentPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingDepartmentPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingDepartmentPermission, 0),
            -- Employee CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingEmployeePermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingEmployeePermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingEmployeePermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingEmployeePermission, 0),
            -- EndUser CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingEndUserPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingEndUserPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingEndUserPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingEndUserPermission, 0),
            -- Role CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingRolePermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingRolePermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingRolePermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingRolePermission, 0),
            -- Location CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingLocationPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingLocationPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingLocationPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingLocationPermission, 0),
            -- Manufacturer CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingManufacturerPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingManufacturerPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingManufacturerPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingManufacturerPermission, 0),
            -- Product CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingProductPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingProductPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingProductPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingProductPermission, 0),
            -- ProductSet CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingProductSetPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingProductSetPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingProductSetPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingProductSetPermission, 0),
            -- Job CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingJobPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingJobPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingJobPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingJobPermission, 0),
            -- Log R Permissions.
            [dbo].[udf_GetDefaultBit](@HasReadingLogPermission, 0),
            -- Vendor CRUD Permissions.
            [dbo].[udf_GetDefaultBit](@HasCreatingVendorPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasReadingVendorPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasUpdatingVendorPermission, 0),
            [dbo].[udf_GetDefaultBit](@HasDeletingVendorPermission, 0)
        );
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
