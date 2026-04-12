CREATE PROCEDURE [dbo].[usp_HasPermission]
    @EndUserIdInNvarchar NVARCHAR(36),
    @Operation NVARCHAR(6), -- Create, Read, Update, and Delete.
    @TableName NVARCHAR(4000)
AS;
BEGIN
    SET NOCOUNT ON;

    DECLARE @EndUserRoleId UNIQUEIDENTIFIER = (
        SELECT EndUserRoleId FROM [dbo].[EndUser]
        WHERE Id = CAST(@EndUserIdInNvarchar AS UNIQUEIDENTIFIER)
    );

    IF (@EndUserRoleId IS NULL)
        BEGIN
            RAISERROR ('EndUser does not exist!', 11, 0);
            RETURN -1;
        END;

    DECLARE @HasPermission BIT = CASE @TableName
        WHEN 'Asset'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingAssetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingAssetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingAssetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingAssetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Building'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingBuildingPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingBuildingPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingBuildingPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingBuildingPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Category'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingCategoryPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingCategoryPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingCategoryPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingCategoryPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Company'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingCompanyPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingCompanyPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingCompanyPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingCompanyPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Department'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingDepartmentPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingDepartmentPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingDepartmentPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingDepartmentPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Employee'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingEmployeePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingEmployeePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingEmployeePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingEmployeePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'EndUserRole'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingEndUserRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingEndUserRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingEndUserRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingEndUserRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Location'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingLocationPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingLocationPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingLocationPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingLocationPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Manufacturer'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingManufacturerPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingManufacturerPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingManufacturerPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingManufacturerPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Product'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingProductPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingProductPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingProductPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingProductPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'ProductSet'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingProductSetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingProductSetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingProductSetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingProductSetPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Role'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingRolePermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'StoredProcedureLog'
            THEN CASE @Operation
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingStoredProcedureLogPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
        WHEN 'Vendor'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingVendorPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingVendorPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingVendorPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingVendorPermission FROM [dbo].[EndUserRole]
                        WHERE Id = @EndUserRoleId
                    )
            END
    END;

    IF (@HasPermission IS NULL)
        BEGIN
            RAISERROR ('Permission does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasPermission = 0)
        BEGIN
            RAISERROR ('EndUser has no permission!', 11, 0);
            RETURN -1;
        END
END;
