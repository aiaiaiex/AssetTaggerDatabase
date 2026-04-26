CREATE PROCEDURE [dbo].[usp_HasPermission]
    @EndUserId UNIQUEIDENTIFIER,
    @Operation NVARCHAR(6), -- Create, Read, Update, and Delete.
    @TableName NVARCHAR(4000)
AS;
BEGIN
    SET NOCOUNT ON;

    DECLARE @RoleId UNIQUEIDENTIFIER = (
        SELECT RoleId FROM [dbo].[EndUser]
        WHERE Id = @EndUserId
    );

    IF (@RoleId IS NULL)
        BEGIN
            RAISERROR ('EndUser does not exist!', 11, 0);
            RETURN -1;
        END;

    DECLARE @HasPermission BIT = CASE @TableName
        WHEN 'Asset'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingAssetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingAssetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingAssetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingAssetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Building'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingBuildingPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingBuildingPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingBuildingPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingBuildingPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Category'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingCategoryPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingCategoryPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingCategoryPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingCategoryPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Company'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingCompanyPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingCompanyPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingCompanyPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingCompanyPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Department'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingDepartmentPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingDepartmentPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingDepartmentPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingDepartmentPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Employee'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingEmployeePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingEmployeePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingEmployeePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingEmployeePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'EndUser'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingEndUserPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingEndUserPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingEndUserPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingEndUserPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Role'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingRolePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingRolePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingRolePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingRolePermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Location'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingLocationPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingLocationPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingLocationPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingLocationPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Manufacturer'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingManufacturerPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingManufacturerPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingManufacturerPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingManufacturerPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Product'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingProductPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingProductPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingProductPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingProductPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'ProductSet'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingProductSetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingProductSetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingProductSetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingProductSetPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Job'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingJobPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingJobPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingJobPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingJobPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Log'
            THEN CASE @Operation
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingLogPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
            END
        WHEN 'Vendor'
            THEN CASE @Operation
                WHEN 'Create'
                    THEN (
                        SELECT HasCreatingVendorPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Read'
                    THEN (
                        SELECT HasReadingVendorPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Update'
                    THEN (
                        SELECT HasUpdatingVendorPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
                    )
                WHEN 'Delete'
                    THEN (
                        SELECT HasDeletingVendorPermission FROM [dbo].[Role]
                        WHERE Id = @RoleId
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
