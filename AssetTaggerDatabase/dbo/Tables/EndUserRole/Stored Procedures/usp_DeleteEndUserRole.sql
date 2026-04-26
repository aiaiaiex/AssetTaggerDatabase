CREATE PROCEDURE [dbo].[usp_DeleteEndUserRole]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Delete';
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
            -- Job CRUD Permissions.
            DELETED.HasCreatingJobPermission,
            DELETED.HasReadingJobPermission,
            DELETED.HasUpdatingJobPermission,
            DELETED.HasDeletingJobPermission,
            -- Log R Permissions.
            DELETED.HasReadingLogPermission,
            -- Vendor CRUD Permissions.
            DELETED.HasCreatingVendorPermission,
            DELETED.HasReadingVendorPermission,
            DELETED.HasUpdatingVendorPermission,
            DELETED.HasDeletingVendorPermission
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
