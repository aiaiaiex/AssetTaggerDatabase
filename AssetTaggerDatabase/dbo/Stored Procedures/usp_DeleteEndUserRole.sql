CREATE PROCEDURE [dbo].[usp_DeleteEndUserRole]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserRoleID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteEndUserRole BIT = (SELECT DeleteEndUserRole FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteEndUserRole IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteEndUserRole = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete an EndUserRole!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[EndUserRole]
    OUTPUT
        DELETED.EndUserRoleID,
        DELETED.EndUserRoleName,
        DELETED.EndUserRoleCreationDate,
        DELETED.CreateAsset,
        DELETED.ReadAsset,
        DELETED.UpdateAsset,
        DELETED.DeleteAsset,
        DELETED.CreateAssetFix,
        DELETED.ReadAssetFix,
        DELETED.UpdateAssetFix,
        DELETED.DeleteAssetFix,
        DELETED.CreateAssetIssue,
        DELETED.ReadAssetIssue,
        DELETED.UpdateAssetIssue,
        DELETED.DeleteAssetIssue,
        DELETED.CreateAssetTransfer,
        DELETED.ReadAssetTransfer,
        DELETED.UpdateAssetTransfer,
        DELETED.DeleteAssetTransfer,
        DELETED.CreateBuilding,
        DELETED.ReadBuilding,
        DELETED.UpdateBuilding,
        DELETED.DeleteBuilding,
        DELETED.CreateCategory,
        DELETED.ReadCategory,
        DELETED.UpdateCategory,
        DELETED.DeleteCategory,
        DELETED.CreateCompany,
        DELETED.ReadCompany,
        DELETED.UpdateCompany,
        DELETED.DeleteCompany,
        DELETED.CreateDepartment,
        DELETED.ReadDepartment,
        DELETED.UpdateDepartment,
        DELETED.DeleteDepartment,
        DELETED.CreateEmployee,
        DELETED.ReadEmployee,
        DELETED.UpdateEmployee,
        DELETED.DeleteEmployee,
        DELETED.CreateEndUser,
        DELETED.ReadEndUser,
        DELETED.UpdateEndUser,
        DELETED.DeleteEndUser,
        DELETED.CreateEndUserRole,
        DELETED.ReadEndUserRole,
        DELETED.UpdateEndUserRole,
        DELETED.DeleteEndUserRole,
        DELETED.CreateLocation,
        DELETED.ReadLocation,
        DELETED.UpdateLocation,
        DELETED.DeleteLocation,
        DELETED.ReadLog,
        DELETED.DeleteLog,
        DELETED.CreateManufacturer,
        DELETED.ReadManufacturer,
        DELETED.UpdateManufacturer,
        DELETED.DeleteManufacturer,
        DELETED.CreateProduct,
        DELETED.ReadProduct,
        DELETED.UpdateProduct,
        DELETED.DeleteProduct,
        DELETED.CreateProductSet,
        DELETED.ReadProductSet,
        DELETED.UpdateProductSet,
        DELETED.DeleteProductSet,
        DELETED.CreateRole,
        DELETED.ReadRole,
        DELETED.UpdateRole,
        DELETED.DeleteRole,
        DELETED.CreateVendor,
        DELETED.ReadVendor,
        DELETED.UpdateVendor,
        DELETED.DeleteVendor
    FROM [dbo].[EndUserRole]
    WHERE EndUserRoleID = @EndUserRoleID;
END;
