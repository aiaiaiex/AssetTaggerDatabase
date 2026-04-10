CREATE PROCEDURE [dbo].[usp_ReadEndUserRole]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(850) = NULL,
    @HasCreatingAssetPermission BIT = NULL,
    @HasReadingAssetPermission BIT = NULL,
    @HasUpdatingAssetPermission BIT = NULL,
    @HasDeletingAssetPermission BIT = NULL,
    @HasCreatingBuildingPermission BIT = NULL,
    @HasReadingBuildingPermission BIT = NULL,
    @HasUpdatingBuildingPermission BIT = NULL,
    @HasDeletingBuildingPermission BIT = NULL,
    @HasCreatingCategoryPermission BIT = NULL,
    @HasReadingCategoryPermission BIT = NULL,
    @HasUpdatingCategoryPermission BIT = NULL,
    @HasDeletingCategoryPermission BIT = NULL,
    @HasCreatingCompanyPermission BIT = NULL,
    @HasReadingCompanyPermission BIT = NULL,
    @HasUpdatingCompanyPermission BIT = NULL,
    @HasDeletingCompanyPermission BIT = NULL,
    @HasCreatingDepartmentPermission BIT = NULL,
    @HasReadingDepartmentPermission BIT = NULL,
    @HasUpdatingDepartmentPermission BIT = NULL,
    @HasDeletingDepartmentPermission BIT = NULL,
    @HasCreatingEmployeePermission BIT = NULL,
    @HasReadingEmployeePermission BIT = NULL,
    @HasUpdatingEmployeePermission BIT = NULL,
    @HasDeletingEmployeePermission BIT = NULL,
    @HasCreatingEndUserPermission BIT = NULL,
    @HasReadingEndUserPermission BIT = NULL,
    @HasUpdatingEndUserPermission BIT = NULL,
    @HasDeletingEndUserPermission BIT = NULL,
    @HasCreatingEndUserRolePermission BIT = NULL,
    @HasReadingEndUserRolePermission BIT = NULL,
    @HasUpdatingEndUserRolePermission BIT = NULL,
    @HasDeletingEndUserRolePermission BIT = NULL,
    @HasCreatingLocationPermission BIT = NULL,
    @HasReadingLocationPermission BIT = NULL,
    @HasUpdatingLocationPermission BIT = NULL,
    @HasDeletingLocationPermission BIT = NULL,
    @HasCreatingManufacturerPermission BIT = NULL,
    @HasReadingManufacturerPermission BIT = NULL,
    @HasUpdatingManufacturerPermission BIT = NULL,
    @HasDeletingManufacturerPermission BIT = NULL,
    @HasCreatingProductPermission BIT = NULL,
    @HasReadingProductPermission BIT = NULL,
    @HasUpdatingProductPermission BIT = NULL,
    @HasDeletingProductPermission BIT = NULL,
    @HasCreatingProductSetPermission BIT = NULL,
    @HasReadingProductSetPermission BIT = NULL,
    @HasUpdatingProductSetPermission BIT = NULL,
    @HasDeletingProductSetPermission BIT = NULL,
    @HasCreatingRolePermission BIT = NULL,
    @HasReadingRolePermission BIT = NULL,
    @HasUpdatingRolePermission BIT = NULL,
    @HasDeletingRolePermission BIT = NULL,
    @HasReadingStoredProcedureLogPermission BIT = NULL,
    @HasCreatingVendorPermission BIT = NULL,
    @HasReadingVendorPermission BIT = NULL,
    @HasUpdatingVendorPermission BIT = NULL,
    @HasDeletingVendorPermission BIT = NULL,
    @FromEndUserRoleCreationDate DATETIME2(3) = NULL,
    @ToEndUserRoleCreationDate DATETIME2(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingEndUserRolePermissionPermission BIT = (SELECT HasReadingEndUserRolePermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingEndUserRolePermissionPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingEndUserRolePermissionPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read EndUserRole!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        Name,
        HasCreatingAssetPermission,
        HasReadingAssetPermission,
        HasUpdatingAssetPermission,
        HasDeletingAssetPermission,
        HasCreatingBuildingPermission,
        HasReadingBuildingPermission,
        HasUpdatingBuildingPermission,
        HasDeletingBuildingPermission,
        HasCreatingCategoryPermission,
        HasReadingCategoryPermission,
        HasUpdatingCategoryPermission,
        HasDeletingCategoryPermission,
        HasCreatingCompanyPermission,
        HasReadingCompanyPermission,
        HasUpdatingCompanyPermission,
        HasDeletingCompanyPermission,
        HasCreatingDepartmentPermission,
        HasReadingDepartmentPermission,
        HasUpdatingDepartmentPermission,
        HasDeletingDepartmentPermission,
        HasCreatingEmployeePermission,
        HasReadingEmployeePermission,
        HasUpdatingEmployeePermission,
        HasDeletingEmployeePermission,
        HasCreatingEndUserPermission,
        HasReadingEndUserPermission,
        HasUpdatingEndUserPermission,
        HasDeletingEndUserPermission,
        HasCreatingEndUserRolePermission,
        HasReadingEndUserRolePermission,
        HasUpdatingEndUserRolePermission,
        HasDeletingEndUserRolePermission,
        HasCreatingLocationPermission,
        HasReadingLocationPermission,
        HasUpdatingLocationPermission,
        HasDeletingLocationPermission,
        HasCreatingManufacturerPermission,
        HasReadingManufacturerPermission,
        HasUpdatingManufacturerPermission,
        HasDeletingManufacturerPermission,
        HasCreatingProductPermission,
        HasReadingProductPermission,
        HasUpdatingProductPermission,
        HasDeletingProductPermission,
        HasCreatingProductSetPermission,
        HasReadingProductSetPermission,
        HasUpdatingProductSetPermission,
        HasDeletingProductSetPermission,
        HasCreatingRolePermission,
        HasReadingRolePermission,
        HasUpdatingRolePermission,
        HasDeletingRolePermission,
        HasReadingStoredProcedureLogPermission,
        HasCreatingVendorPermission,
        HasReadingVendorPermission,
        HasUpdatingVendorPermission,
        HasDeletingVendorPermission,
        EndUserRoleCreationDate
    FROM
        [dbo].[EndUserRole]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (Name = COALESCE(@Name, Name) OR Name LIKE @Name)
        AND HasCreatingAssetPermission = COALESCE(@HasCreatingAssetPermission, HasCreatingAssetPermission)
        AND HasReadingAssetPermission = COALESCE(@HasReadingAssetPermission, HasReadingAssetPermission)
        AND HasUpdatingAssetPermission = COALESCE(@HasUpdatingAssetPermission, HasUpdatingAssetPermission)
        AND HasDeletingAssetPermission = COALESCE(@HasDeletingAssetPermission, HasDeletingAssetPermission)
        AND HasCreatingBuildingPermission = COALESCE(@HasCreatingBuildingPermission, HasCreatingBuildingPermission)
        AND HasReadingBuildingPermission = COALESCE(@HasReadingBuildingPermission, HasReadingBuildingPermission)
        AND HasUpdatingBuildingPermission = COALESCE(@HasUpdatingBuildingPermission, HasUpdatingBuildingPermission)
        AND HasDeletingBuildingPermission = COALESCE(@HasDeletingBuildingPermission, HasDeletingBuildingPermission)
        AND HasCreatingCategoryPermission = COALESCE(@HasCreatingCategoryPermission, HasCreatingCategoryPermission)
        AND HasReadingCategoryPermission = COALESCE(@HasReadingCategoryPermission, HasReadingCategoryPermission)
        AND HasUpdatingCategoryPermission = COALESCE(@HasUpdatingCategoryPermission, HasUpdatingCategoryPermission)
        AND HasDeletingCategoryPermission = COALESCE(@HasDeletingCategoryPermission, HasDeletingCategoryPermission)
        AND HasCreatingCompanyPermission = COALESCE(@HasCreatingCompanyPermission, HasCreatingCompanyPermission)
        AND HasReadingCompanyPermission = COALESCE(@HasReadingCompanyPermission, HasReadingCompanyPermission)
        AND HasUpdatingCompanyPermission = COALESCE(@HasUpdatingCompanyPermission, HasUpdatingCompanyPermission)
        AND HasDeletingCompanyPermission = COALESCE(@HasDeletingCompanyPermission, HasDeletingCompanyPermission)
        AND HasCreatingDepartmentPermission = COALESCE(@HasCreatingDepartmentPermission, HasCreatingDepartmentPermission)
        AND HasReadingDepartmentPermission = COALESCE(@HasReadingDepartmentPermission, HasReadingDepartmentPermission)
        AND HasUpdatingDepartmentPermission = COALESCE(@HasUpdatingDepartmentPermission, HasUpdatingDepartmentPermission)
        AND HasDeletingDepartmentPermission = COALESCE(@HasDeletingDepartmentPermission, HasDeletingDepartmentPermission)
        AND HasCreatingEmployeePermission = COALESCE(@HasCreatingEmployeePermission, HasCreatingEmployeePermission)
        AND HasReadingEmployeePermission = COALESCE(@HasReadingEmployeePermission, HasReadingEmployeePermission)
        AND HasUpdatingEmployeePermission = COALESCE(@HasUpdatingEmployeePermission, HasUpdatingEmployeePermission)
        AND HasDeletingEmployeePermission = COALESCE(@HasDeletingEmployeePermission, HasDeletingEmployeePermission)
        AND HasCreatingEndUserPermission = COALESCE(@HasCreatingEndUserPermission, HasCreatingEndUserPermission)
        AND HasReadingEndUserPermission = COALESCE(@HasReadingEndUserPermission, HasReadingEndUserPermission)
        AND HasUpdatingEndUserPermission = COALESCE(@HasUpdatingEndUserPermission, HasUpdatingEndUserPermission)
        AND HasDeletingEndUserPermission = COALESCE(@HasDeletingEndUserPermission, HasDeletingEndUserPermission)
        AND HasCreatingEndUserRolePermission = COALESCE(@HasCreatingEndUserRolePermission, HasCreatingEndUserRolePermission)
        AND HasReadingEndUserRolePermission = COALESCE(@HasReadingEndUserRolePermission, HasReadingEndUserRolePermission)
        AND HasUpdatingEndUserRolePermission = COALESCE(@HasUpdatingEndUserRolePermission, HasUpdatingEndUserRolePermission)
        AND HasDeletingEndUserRolePermission = COALESCE(@HasDeletingEndUserRolePermission, HasDeletingEndUserRolePermission)
        AND HasCreatingLocationPermission = COALESCE(@HasCreatingLocationPermission, HasCreatingLocationPermission)
        AND HasReadingLocationPermission = COALESCE(@HasReadingLocationPermission, HasReadingLocationPermission)
        AND HasUpdatingLocationPermission = COALESCE(@HasUpdatingLocationPermission, HasUpdatingLocationPermission)
        AND HasDeletingLocationPermission = COALESCE(@HasDeletingLocationPermission, HasDeletingLocationPermission)
        AND HasCreatingManufacturerPermission = COALESCE(@HasCreatingManufacturerPermission, HasCreatingManufacturerPermission)
        AND HasReadingManufacturerPermission = COALESCE(@HasReadingManufacturerPermission, HasReadingManufacturerPermission)
        AND HasUpdatingManufacturerPermission = COALESCE(@HasUpdatingManufacturerPermission, HasUpdatingManufacturerPermission)
        AND HasDeletingManufacturerPermission = COALESCE(@HasDeletingManufacturerPermission, HasDeletingManufacturerPermission)
        AND HasCreatingProductPermission = COALESCE(@HasCreatingProductPermission, HasCreatingProductPermission)
        AND HasReadingProductPermission = COALESCE(@HasReadingProductPermission, HasReadingProductPermission)
        AND HasUpdatingProductPermission = COALESCE(@HasUpdatingProductPermission, HasUpdatingProductPermission)
        AND HasDeletingProductPermission = COALESCE(@HasDeletingProductPermission, HasDeletingProductPermission)
        AND HasCreatingProductSetPermission = COALESCE(@HasCreatingProductSetPermission, HasCreatingProductSetPermission)
        AND HasReadingProductSetPermission = COALESCE(@HasReadingProductSetPermission, HasReadingProductSetPermission)
        AND HasUpdatingProductSetPermission = COALESCE(@HasUpdatingProductSetPermission, HasUpdatingProductSetPermission)
        AND HasDeletingProductSetPermission = COALESCE(@HasDeletingProductSetPermission, HasDeletingProductSetPermission)
        AND HasCreatingRolePermission = COALESCE(@HasCreatingRolePermission, HasCreatingRolePermission)
        AND HasReadingRolePermission = COALESCE(@HasReadingRolePermission, HasReadingRolePermission)
        AND HasUpdatingRolePermission = COALESCE(@HasUpdatingRolePermission, HasUpdatingRolePermission)
        AND HasDeletingRolePermission = COALESCE(@HasDeletingRolePermission, HasDeletingRolePermission)
        AND HasReadingStoredProcedureLogPermission = COALESCE(@HasReadingStoredProcedureLogPermission, HasReadingStoredProcedureLogPermission)
        AND HasCreatingVendorPermission = COALESCE(@HasCreatingVendorPermission, HasCreatingVendorPermission)
        AND HasReadingVendorPermission = COALESCE(@HasReadingVendorPermission, HasReadingVendorPermission)
        AND HasUpdatingVendorPermission = COALESCE(@HasUpdatingVendorPermission, HasUpdatingVendorPermission)
        AND HasDeletingVendorPermission = COALESCE(@HasDeletingVendorPermission, HasDeletingVendorPermission)
        AND COALESCE(@FromEndUserRoleCreationDate, EndUserRoleCreationDate) <= EndUserRoleCreationDate
        AND EndUserRoleCreationDate <= COALESCE(@ToEndUserRoleCreationDate, EndUserRoleCreationDate)
    ORDER BY
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET COALESCE(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT COALESCE(@RowsToReturn, 2147483647) ROWS ONLY;
END;
