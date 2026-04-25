CREATE PROCEDURE [dbo].[usp_ReadEndUserRole]
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
    @HasDeletingVendorPermission NVARCHAR(1) = '',
    -- DATETIME2(3) range parameters.
    @FromCreatedAt NVARCHAR(24) = '',
    @ToCreatedAt NVARCHAR(24) = '',
    -- Sort parameters.
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = '',
    -- Pagination parameters.
    @RowsToSkip NVARCHAR(19) = '',
    @RowsToReturn NVARCHAR(19) = ''
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
        -- Role CRUD Permissions.
        '@HasCreatingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingRolePermission), ''', ',
        '@HasReadingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingRolePermission), ''', ',
        '@HasUpdatingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingRolePermission), ''', ',
        '@HasDeletingRolePermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingRolePermission), ''', ',
        -- StoredProcedureLog R Permissions.
        '@HasReadingStoredProcedureLogPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingStoredProcedureLogPermission), ''', ',
        -- Vendor CRUD Permissions.
        '@HasCreatingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasCreatingVendorPermission), ''', ',
        '@HasReadingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasReadingVendorPermission), ''', ',
        '@HasUpdatingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasUpdatingVendorPermission), ''', ',
        '@HasDeletingVendorPermission = ''', [dbo].[udf_ConvertNullToNvarchar](@HasDeletingVendorPermission), ''', ',
        -- DATETIME2(3) range parameters.
        '@FromCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@FromCreatedAt), ''', ',
        '@ToCreatedAt = ''', [dbo].[udf_ConvertNullToNvarchar](@ToCreatedAt), ''', ',
        -- Sort parameters.
        '@SortColumn = ''', [dbo].[udf_ConvertNullToNvarchar](@SortColumn), ''', ',
        '@RowOrder = ''', [dbo].[udf_ConvertNullToNvarchar](@RowOrder), ''', ',
        -- Pagination parameters.
        '@RowsToSkip = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToSkip), ''', ',
        '@RowsToReturn = ''', [dbo].[udf_ConvertNullToNvarchar](@RowsToReturn), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Read';
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

        -- Set final values.
        SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
        SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

        -- Run actual query.
        SELECT
        -- Non-nullable columns with default values.
            CreatedAt,
            Id,
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
        FROM
            [dbo].[EndUserRole]
        WHERE
        -- Non-nullable columns with default values.
            [dbo].[udf_IsEqualToUniqueIdentifier](@Id, Id) = 1
            -- Non-nullable columns.
            AND [dbo].[udf_IsEqualToOrLikeNvarchar](@Name, Name) = 1
            -- DATETIME2(3) range parameters.
            AND [dbo].[udf_IsBetweenDatetime2s](@FromCreatedAt, CreatedAt, @ToCreatedAt) = 1
            -- Permissions.
            -- Asset CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingAssetPermission, HasCreatingAssetPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingAssetPermission, HasReadingAssetPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingAssetPermission, HasUpdatingAssetPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingAssetPermission, HasDeletingAssetPermission) = 1
            -- Building CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingBuildingPermission, HasCreatingBuildingPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingBuildingPermission, HasReadingBuildingPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingBuildingPermission, HasUpdatingBuildingPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingBuildingPermission, HasDeletingBuildingPermission) = 1
            -- Category CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingCategoryPermission, HasCreatingCategoryPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingCategoryPermission, HasReadingCategoryPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingCategoryPermission, HasUpdatingCategoryPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingCategoryPermission, HasDeletingCategoryPermission) = 1
            -- Company CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingCompanyPermission, HasCreatingCompanyPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingCompanyPermission, HasReadingCompanyPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingCompanyPermission, HasUpdatingCompanyPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingCompanyPermission, HasDeletingCompanyPermission) = 1
            -- Department CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingDepartmentPermission, HasCreatingDepartmentPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingDepartmentPermission, HasReadingDepartmentPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingDepartmentPermission, HasUpdatingDepartmentPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingDepartmentPermission, HasDeletingDepartmentPermission) = 1
            -- Employee CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingEmployeePermission, HasCreatingEmployeePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingEmployeePermission, HasReadingEmployeePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingEmployeePermission, HasUpdatingEmployeePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingEmployeePermission, HasDeletingEmployeePermission) = 1
            -- EndUser CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingEndUserPermission, HasCreatingEndUserPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingEndUserPermission, HasReadingEndUserPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingEndUserPermission, HasUpdatingEndUserPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingEndUserPermission, HasDeletingEndUserPermission) = 1
            -- EndUserRole CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingEndUserRolePermission, HasCreatingEndUserRolePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingEndUserRolePermission, HasReadingEndUserRolePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingEndUserRolePermission, HasUpdatingEndUserRolePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingEndUserRolePermission, HasDeletingEndUserRolePermission) = 1
            -- Location CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingLocationPermission, HasCreatingLocationPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingLocationPermission, HasReadingLocationPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingLocationPermission, HasUpdatingLocationPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingLocationPermission, HasDeletingLocationPermission) = 1
            -- Manufacturer CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingManufacturerPermission, HasCreatingManufacturerPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingManufacturerPermission, HasReadingManufacturerPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingManufacturerPermission, HasUpdatingManufacturerPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingManufacturerPermission, HasDeletingManufacturerPermission) = 1
            -- Product CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingProductPermission, HasCreatingProductPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingProductPermission, HasReadingProductPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingProductPermission, HasUpdatingProductPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingProductPermission, HasDeletingProductPermission) = 1
            -- ProductSet CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingProductSetPermission, HasCreatingProductSetPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingProductSetPermission, HasReadingProductSetPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingProductSetPermission, HasUpdatingProductSetPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingProductSetPermission, HasDeletingProductSetPermission) = 1
            -- Role CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingRolePermission, HasCreatingRolePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingRolePermission, HasReadingRolePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingRolePermission, HasUpdatingRolePermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingRolePermission, HasDeletingRolePermission) = 1
            -- StoredProcedureLog R Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasReadingStoredProcedureLogPermission, HasReadingStoredProcedureLogPermission) = 1
            -- Vendor CRUD Permissions.
            AND [dbo].[udf_IsEqualToBit](@HasCreatingVendorPermission, HasCreatingVendorPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasReadingVendorPermission, HasReadingVendorPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasUpdatingVendorPermission, HasUpdatingVendorPermission) = 1
            AND [dbo].[udf_IsEqualToBit](@HasDeletingVendorPermission, HasDeletingVendorPermission) = 1
        ORDER BY
        -- Descending sort.
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'Name')) THEN Name END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingAssetPermission')) THEN HasCreatingAssetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingAssetPermission')) THEN HasReadingAssetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingAssetPermission')) THEN HasUpdatingAssetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingAssetPermission')) THEN HasDeletingAssetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingBuildingPermission')) THEN HasCreatingBuildingPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingBuildingPermission')) THEN HasReadingBuildingPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingBuildingPermission')) THEN HasUpdatingBuildingPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingBuildingPermission')) THEN HasDeletingBuildingPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingCategoryPermission')) THEN HasCreatingCategoryPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingCategoryPermission')) THEN HasReadingCategoryPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingCategoryPermission')) THEN HasUpdatingCategoryPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingCategoryPermission')) THEN HasDeletingCategoryPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingCompanyPermission')) THEN HasCreatingCompanyPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingCompanyPermission')) THEN HasReadingCompanyPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingCompanyPermission')) THEN HasUpdatingCompanyPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingCompanyPermission')) THEN HasDeletingCompanyPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingDepartmentPermission')) THEN HasCreatingDepartmentPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingDepartmentPermission')) THEN HasReadingDepartmentPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingDepartmentPermission')) THEN HasUpdatingDepartmentPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingDepartmentPermission')) THEN HasDeletingDepartmentPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingEmployeePermission')) THEN HasCreatingEmployeePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingEmployeePermission')) THEN HasReadingEmployeePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingEmployeePermission')) THEN HasUpdatingEmployeePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingEmployeePermission')) THEN HasDeletingEmployeePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingEndUserPermission')) THEN HasCreatingEndUserPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingEndUserPermission')) THEN HasReadingEndUserPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingEndUserPermission')) THEN HasUpdatingEndUserPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingEndUserPermission')) THEN HasDeletingEndUserPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingEndUserRolePermission')) THEN HasCreatingEndUserRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingEndUserRolePermission')) THEN HasReadingEndUserRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingEndUserRolePermission')) THEN HasUpdatingEndUserRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingEndUserRolePermission')) THEN HasDeletingEndUserRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingLocationPermission')) THEN HasCreatingLocationPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingLocationPermission')) THEN HasReadingLocationPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingLocationPermission')) THEN HasUpdatingLocationPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingLocationPermission')) THEN HasDeletingLocationPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingManufacturerPermission')) THEN HasCreatingManufacturerPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingManufacturerPermission')) THEN HasReadingManufacturerPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingManufacturerPermission')) THEN HasUpdatingManufacturerPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingManufacturerPermission')) THEN HasDeletingManufacturerPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingProductPermission')) THEN HasCreatingProductPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingProductPermission')) THEN HasReadingProductPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingProductPermission')) THEN HasUpdatingProductPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingProductPermission')) THEN HasDeletingProductPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingProductSetPermission')) THEN HasCreatingProductSetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingProductSetPermission')) THEN HasReadingProductSetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingProductSetPermission')) THEN HasUpdatingProductSetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingProductSetPermission')) THEN HasDeletingProductSetPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingRolePermission')) THEN HasCreatingRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingRolePermission')) THEN HasReadingRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingRolePermission')) THEN HasUpdatingRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingRolePermission')) THEN HasDeletingRolePermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingStoredProcedureLogPermission')) THEN HasReadingStoredProcedureLogPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasCreatingVendorPermission')) THEN HasCreatingVendorPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasReadingVendorPermission')) THEN HasReadingVendorPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasUpdatingVendorPermission')) THEN HasUpdatingVendorPermission END DESC,
            CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'HasDeletingVendorPermission')) THEN HasDeletingVendorPermission END DESC,
            -- Ascending sort.
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'CreatedAt')) THEN CreatedAt END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'Name')) THEN Name END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingAssetPermission')) THEN HasCreatingAssetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingAssetPermission')) THEN HasReadingAssetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingAssetPermission')) THEN HasUpdatingAssetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingAssetPermission')) THEN HasDeletingAssetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingBuildingPermission')) THEN HasCreatingBuildingPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingBuildingPermission')) THEN HasReadingBuildingPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingBuildingPermission')) THEN HasUpdatingBuildingPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingBuildingPermission')) THEN HasDeletingBuildingPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingCategoryPermission')) THEN HasCreatingCategoryPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingCategoryPermission')) THEN HasReadingCategoryPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingCategoryPermission')) THEN HasUpdatingCategoryPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingCategoryPermission')) THEN HasDeletingCategoryPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingCompanyPermission')) THEN HasCreatingCompanyPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingCompanyPermission')) THEN HasReadingCompanyPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingCompanyPermission')) THEN HasUpdatingCompanyPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingCompanyPermission')) THEN HasDeletingCompanyPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingDepartmentPermission')) THEN HasCreatingDepartmentPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingDepartmentPermission')) THEN HasReadingDepartmentPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingDepartmentPermission')) THEN HasUpdatingDepartmentPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingDepartmentPermission')) THEN HasDeletingDepartmentPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingEmployeePermission')) THEN HasCreatingEmployeePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingEmployeePermission')) THEN HasReadingEmployeePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingEmployeePermission')) THEN HasUpdatingEmployeePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingEmployeePermission')) THEN HasDeletingEmployeePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingEndUserPermission')) THEN HasCreatingEndUserPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingEndUserPermission')) THEN HasReadingEndUserPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingEndUserPermission')) THEN HasUpdatingEndUserPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingEndUserPermission')) THEN HasDeletingEndUserPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingEndUserRolePermission')) THEN HasCreatingEndUserRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingEndUserRolePermission')) THEN HasReadingEndUserRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingEndUserRolePermission')) THEN HasUpdatingEndUserRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingEndUserRolePermission')) THEN HasDeletingEndUserRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingLocationPermission')) THEN HasCreatingLocationPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingLocationPermission')) THEN HasReadingLocationPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingLocationPermission')) THEN HasUpdatingLocationPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingLocationPermission')) THEN HasDeletingLocationPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingManufacturerPermission')) THEN HasCreatingManufacturerPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingManufacturerPermission')) THEN HasReadingManufacturerPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingManufacturerPermission')) THEN HasUpdatingManufacturerPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingManufacturerPermission')) THEN HasDeletingManufacturerPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingProductPermission')) THEN HasCreatingProductPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingProductPermission')) THEN HasReadingProductPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingProductPermission')) THEN HasUpdatingProductPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingProductPermission')) THEN HasDeletingProductPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingProductSetPermission')) THEN HasCreatingProductSetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingProductSetPermission')) THEN HasReadingProductSetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingProductSetPermission')) THEN HasUpdatingProductSetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingProductSetPermission')) THEN HasDeletingProductSetPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingRolePermission')) THEN HasCreatingRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingRolePermission')) THEN HasReadingRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingRolePermission')) THEN HasUpdatingRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingRolePermission')) THEN HasDeletingRolePermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingStoredProcedureLogPermission')) THEN HasReadingStoredProcedureLogPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasCreatingVendorPermission')) THEN HasCreatingVendorPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasReadingVendorPermission')) THEN HasReadingVendorPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasUpdatingVendorPermission')) THEN HasUpdatingVendorPermission END ASC,
            CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'HasDeletingVendorPermission')) THEN HasDeletingVendorPermission END ASC
            -- Pagination.
            OFFSET [dbo].[udf_GetRowsToSkipInBigint](@RowsToSkip) ROWS
            FETCH NEXT [dbo].[udf_GetRowsToReturn](@RowsToReturn) ROWS ONLY;
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateStoredProcedureLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
