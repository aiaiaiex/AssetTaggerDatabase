CREATE PROCEDURE [dbo].[usp_ReadEndUserRole]
    @CallingEndUserId NVARCHAR(36),
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
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @SortColumn NVARCHAR(4000) = '',
    @RowOrder NVARCHAR(4) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'EndUserRole';

    -- Set final values.
    SET @SortColumn = [dbo].[udf_GetSortColumn](@SortColumn);
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

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
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END DESC,
        CASE WHEN ((@RowOrder = 'DESC') AND (@SortColumn = 'EndUserRoleCreationDate')) THEN EndUserRoleCreationDate END DESC,
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
        -- 
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'RowNumber')) THEN RowNumber END ASC,
        CASE WHEN ((@RowOrder = 'ASC') AND (@SortColumn = 'EndUserRoleCreationDate')) THEN EndUserRoleCreationDate END ASC,
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
        -- 
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
