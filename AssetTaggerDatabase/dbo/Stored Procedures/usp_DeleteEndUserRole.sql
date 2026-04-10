CREATE PROCEDURE [dbo].[usp_DeleteEndUserRole]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingEndUserRolePermission BIT = (SELECT HasDeletingEndUserRolePermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingEndUserRolePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingEndUserRolePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete an EndUserRole!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[EndUserRole]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.EndUserRoleCreationDate,
        DELETED.HasCreatingAssetPermission,
        DELETED.HasReadingAssetPermission,
        DELETED.HasUpdatingAssetPermission,
        DELETED.HasDeletingAssetPermission,
        DELETED.HasCreatingBuildingPermission,
        DELETED.HasReadingBuildingPermission,
        DELETED.HasUpdatingBuildingPermission,
        DELETED.HasDeletingBuildingPermission,
        DELETED.HasCreatingCategoryPermission,
        DELETED.HasReadingCategoryPermission,
        DELETED.HasUpdatingCategoryPermission,
        DELETED.HasDeletingCategoryPermission,
        DELETED.HasCreatingCompanyPermission,
        DELETED.HasReadingCompanyPermission,
        DELETED.HasUpdatingCompanyPermission,
        DELETED.HasDeletingCompanyPermission,
        DELETED.HasCreatingDepartmentPermission,
        DELETED.HasReadingDepartmentPermission,
        DELETED.HasUpdatingDepartmentPermission,
        DELETED.HasDeletingDepartmentPermission,
        DELETED.HasCreatingEmployeePermission,
        DELETED.HasReadingEmployeePermission,
        DELETED.HasUpdatingEmployeePermission,
        DELETED.HasDeletingEmployeePermission,
        DELETED.HasCreatingEndUserPermission,
        DELETED.HasReadingEndUserPermission,
        DELETED.HasUpdatingEndUserPermission,
        DELETED.HasDeletingEndUserPermission,
        DELETED.HasCreatingEndUserRolePermission,
        DELETED.HasReadingEndUserRolePermission,
        DELETED.HasUpdatingEndUserRolePermission,
        DELETED.HasDeletingEndUserRolePermission,
        DELETED.HasCreatingLocationPermission,
        DELETED.HasReadingLocationPermission,
        DELETED.HasUpdatingLocationPermission,
        DELETED.HasDeletingLocationPermission,
        DELETED.HasCreatingManufacturerPermission,
        DELETED.HasReadingManufacturerPermission,
        DELETED.HasUpdatingManufacturerPermission,
        DELETED.HasDeletingManufacturerPermission,
        DELETED.HasCreatingProductPermission,
        DELETED.HasReadingProductPermission,
        DELETED.HasUpdatingProductPermission,
        DELETED.HasDeletingProductPermission,
        DELETED.HasCreatingProductSetPermission,
        DELETED.HasReadingProductSetPermission,
        DELETED.HasUpdatingProductSetPermission,
        DELETED.HasDeletingProductSetPermission,
        DELETED.HasCreatingRolePermission,
        DELETED.HasReadingRolePermission,
        DELETED.HasUpdatingRolePermission,
        DELETED.HasDeletingRolePermission,
        DELETED.HasReadingStoredProcedureLogPermission,
        DELETED.HasDeletingStoredProcedureLogPermission,
        DELETED.HasCreatingVendorPermission,
        DELETED.HasReadingVendorPermission,
        DELETED.HasUpdatingVendorPermission,
        DELETED.HasDeletingVendorPermission
    FROM
        [dbo].[EndUserRole]
    WHERE
        Id = @Id;
END;
