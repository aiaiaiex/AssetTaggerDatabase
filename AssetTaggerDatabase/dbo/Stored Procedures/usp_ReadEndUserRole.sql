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
    @HasDeletingStoredProcedureLogPermission BIT = NULL,
    @HasCreatingVendorPermission BIT = NULL,
    @HasReadingVendorPermission BIT = NULL,
    @HasUpdatingVendorPermission BIT = NULL,
    @HasDeletingVendorPermission BIT = NULL,
    @FromEndUserRoleCreationDate DATETIMEOFFSET(3) = NULL,
    @ToEndUserRoleCreationDate DATETIMEOFFSET(3) = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingEndUserRolePermissionPermission BIT = (SELECT HasReadingEndUserRolePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

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
        HasDeletingStoredProcedureLogPermission,
        HasCreatingVendorPermission,
        HasReadingVendorPermission,
        HasUpdatingVendorPermission,
        HasDeletingVendorPermission,
        EndUserRoleCreationDate
    FROM
        [dbo].[EndUserRole]
    WHERE
        Id = ISNULL(@Id, Id)
        AND (Name = ISNULL(@Name, Name) OR Name LIKE @Name)
        AND HasCreatingAssetPermission = ISNULL(@HasCreatingAssetPermission, HasCreatingAssetPermission)
        AND HasReadingAssetPermission = ISNULL(@HasReadingAssetPermission, HasReadingAssetPermission)
        AND HasUpdatingAssetPermission = ISNULL(@HasUpdatingAssetPermission, HasUpdatingAssetPermission)
        AND HasDeletingAssetPermission = ISNULL(@HasDeletingAssetPermission, HasDeletingAssetPermission)
        AND HasCreatingBuildingPermission = ISNULL(@HasCreatingBuildingPermission, HasCreatingBuildingPermission)
        AND HasReadingBuildingPermission = ISNULL(@HasReadingBuildingPermission, HasReadingBuildingPermission)
        AND HasUpdatingBuildingPermission = ISNULL(@HasUpdatingBuildingPermission, HasUpdatingBuildingPermission)
        AND HasDeletingBuildingPermission = ISNULL(@HasDeletingBuildingPermission, HasDeletingBuildingPermission)
        AND HasCreatingCategoryPermission = ISNULL(@HasCreatingCategoryPermission, HasCreatingCategoryPermission)
        AND HasReadingCategoryPermission = ISNULL(@HasReadingCategoryPermission, HasReadingCategoryPermission)
        AND HasUpdatingCategoryPermission = ISNULL(@HasUpdatingCategoryPermission, HasUpdatingCategoryPermission)
        AND HasDeletingCategoryPermission = ISNULL(@HasDeletingCategoryPermission, HasDeletingCategoryPermission)
        AND HasCreatingCompanyPermission = ISNULL(@HasCreatingCompanyPermission, HasCreatingCompanyPermission)
        AND HasReadingCompanyPermission = ISNULL(@HasReadingCompanyPermission, HasReadingCompanyPermission)
        AND HasUpdatingCompanyPermission = ISNULL(@HasUpdatingCompanyPermission, HasUpdatingCompanyPermission)
        AND HasDeletingCompanyPermission = ISNULL(@HasDeletingCompanyPermission, HasDeletingCompanyPermission)
        AND HasCreatingDepartmentPermission = ISNULL(@HasCreatingDepartmentPermission, HasCreatingDepartmentPermission)
        AND HasReadingDepartmentPermission = ISNULL(@HasReadingDepartmentPermission, HasReadingDepartmentPermission)
        AND HasUpdatingDepartmentPermission = ISNULL(@HasUpdatingDepartmentPermission, HasUpdatingDepartmentPermission)
        AND HasDeletingDepartmentPermission = ISNULL(@HasDeletingDepartmentPermission, HasDeletingDepartmentPermission)
        AND HasCreatingEmployeePermission = ISNULL(@HasCreatingEmployeePermission, HasCreatingEmployeePermission)
        AND HasReadingEmployeePermission = ISNULL(@HasReadingEmployeePermission, HasReadingEmployeePermission)
        AND HasUpdatingEmployeePermission = ISNULL(@HasUpdatingEmployeePermission, HasUpdatingEmployeePermission)
        AND HasDeletingEmployeePermission = ISNULL(@HasDeletingEmployeePermission, HasDeletingEmployeePermission)
        AND HasCreatingEndUserPermission = ISNULL(@HasCreatingEndUserPermission, HasCreatingEndUserPermission)
        AND HasReadingEndUserPermission = ISNULL(@HasReadingEndUserPermission, HasReadingEndUserPermission)
        AND HasUpdatingEndUserPermission = ISNULL(@HasUpdatingEndUserPermission, HasUpdatingEndUserPermission)
        AND HasDeletingEndUserPermission = ISNULL(@HasDeletingEndUserPermission, HasDeletingEndUserPermission)
        AND HasCreatingEndUserRolePermission = ISNULL(@HasCreatingEndUserRolePermission, HasCreatingEndUserRolePermission)
        AND HasReadingEndUserRolePermission = ISNULL(@HasReadingEndUserRolePermission, HasReadingEndUserRolePermission)
        AND HasUpdatingEndUserRolePermission = ISNULL(@HasUpdatingEndUserRolePermission, HasUpdatingEndUserRolePermission)
        AND HasDeletingEndUserRolePermission = ISNULL(@HasDeletingEndUserRolePermission, HasDeletingEndUserRolePermission)
        AND HasCreatingLocationPermission = ISNULL(@HasCreatingLocationPermission, HasCreatingLocationPermission)
        AND HasReadingLocationPermission = ISNULL(@HasReadingLocationPermission, HasReadingLocationPermission)
        AND HasUpdatingLocationPermission = ISNULL(@HasUpdatingLocationPermission, HasUpdatingLocationPermission)
        AND HasDeletingLocationPermission = ISNULL(@HasDeletingLocationPermission, HasDeletingLocationPermission)
        AND HasCreatingManufacturerPermission = ISNULL(@HasCreatingManufacturerPermission, HasCreatingManufacturerPermission)
        AND HasReadingManufacturerPermission = ISNULL(@HasReadingManufacturerPermission, HasReadingManufacturerPermission)
        AND HasUpdatingManufacturerPermission = ISNULL(@HasUpdatingManufacturerPermission, HasUpdatingManufacturerPermission)
        AND HasDeletingManufacturerPermission = ISNULL(@HasDeletingManufacturerPermission, HasDeletingManufacturerPermission)
        AND HasCreatingProductPermission = ISNULL(@HasCreatingProductPermission, HasCreatingProductPermission)
        AND HasReadingProductPermission = ISNULL(@HasReadingProductPermission, HasReadingProductPermission)
        AND HasUpdatingProductPermission = ISNULL(@HasUpdatingProductPermission, HasUpdatingProductPermission)
        AND HasDeletingProductPermission = ISNULL(@HasDeletingProductPermission, HasDeletingProductPermission)
        AND HasCreatingProductSetPermission = ISNULL(@HasCreatingProductSetPermission, HasCreatingProductSetPermission)
        AND HasReadingProductSetPermission = ISNULL(@HasReadingProductSetPermission, HasReadingProductSetPermission)
        AND HasUpdatingProductSetPermission = ISNULL(@HasUpdatingProductSetPermission, HasUpdatingProductSetPermission)
        AND HasDeletingProductSetPermission = ISNULL(@HasDeletingProductSetPermission, HasDeletingProductSetPermission)
        AND HasCreatingRolePermission = ISNULL(@HasCreatingRolePermission, HasCreatingRolePermission)
        AND HasReadingRolePermission = ISNULL(@HasReadingRolePermission, HasReadingRolePermission)
        AND HasUpdatingRolePermission = ISNULL(@HasUpdatingRolePermission, HasUpdatingRolePermission)
        AND HasDeletingRolePermission = ISNULL(@HasDeletingRolePermission, HasDeletingRolePermission)
        AND HasReadingStoredProcedureLogPermission = ISNULL(@HasReadingStoredProcedureLogPermission, HasReadingStoredProcedureLogPermission)
        AND HasDeletingStoredProcedureLogPermission = ISNULL(@HasDeletingStoredProcedureLogPermission, HasDeletingStoredProcedureLogPermission)
        AND HasCreatingVendorPermission = ISNULL(@HasCreatingVendorPermission, HasCreatingVendorPermission)
        AND HasReadingVendorPermission = ISNULL(@HasReadingVendorPermission, HasReadingVendorPermission)
        AND HasUpdatingVendorPermission = ISNULL(@HasUpdatingVendorPermission, HasUpdatingVendorPermission)
        AND HasDeletingVendorPermission = ISNULL(@HasDeletingVendorPermission, HasDeletingVendorPermission)
        AND ISNULL(@FromEndUserRoleCreationDate, EndUserRoleCreationDate) <= EndUserRoleCreationDate
        AND EndUserRoleCreationDate <= ISNULL(@ToEndUserRoleCreationDate, EndUserRoleCreationDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
