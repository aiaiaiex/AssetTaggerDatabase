CREATE PROCEDURE [dbo].[usp_ReadEndUserRole]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EndUserRoleName NVARCHAR(850) = NULL,
    @CreateAsset BIT = NULL,
    @ReadAsset BIT = NULL,
    @UpdateAsset BIT = NULL,
    @DeleteAsset BIT = NULL,
    @CreateAssetFix BIT = NULL,
    @ReadAssetFix BIT = NULL,
    @UpdateAssetFix BIT = NULL,
    @DeleteAssetFix BIT = NULL,
    @CreateAssetIssue BIT = NULL,
    @ReadAssetIssue BIT = NULL,
    @UpdateAssetIssue BIT = NULL,
    @DeleteAssetIssue BIT = NULL,
    @CreateAssetTransfer BIT = NULL,
    @ReadAssetTransfer BIT = NULL,
    @UpdateAssetTransfer BIT = NULL,
    @DeleteAssetTransfer BIT = NULL,
    @CreateBuilding BIT = NULL,
    @ReadBuilding BIT = NULL,
    @UpdateBuilding BIT = NULL,
    @DeleteBuilding BIT = NULL,
    @CreateCategory BIT = NULL,
    @ReadCategory BIT = NULL,
    @UpdateCategory BIT = NULL,
    @DeleteCategory BIT = NULL,
    @CreateCompany BIT = NULL,
    @ReadCompany BIT = NULL,
    @UpdateCompany BIT = NULL,
    @DeleteCompany BIT = NULL,
    @CreateDepartment BIT = NULL,
    @ReadDepartment BIT = NULL,
    @UpdateDepartment BIT = NULL,
    @DeleteDepartment BIT = NULL,
    @CreateEmployee BIT = NULL,
    @ReadEmployee BIT = NULL,
    @UpdateEmployee BIT = NULL,
    @DeleteEmployee BIT = NULL,
    @CreateEndUser BIT = NULL,
    @ReadEndUser BIT = NULL,
    @UpdateEndUser BIT = NULL,
    @DeleteEndUser BIT = NULL,
    @CreateEndUserRole BIT = NULL,
    @ReadEndUserRole BIT = NULL,
    @UpdateEndUserRole BIT = NULL,
    @DeleteEndUserRole BIT = NULL,
    @CreateLocation BIT = NULL,
    @ReadLocation BIT = NULL,
    @UpdateLocation BIT = NULL,
    @DeleteLocation BIT = NULL,
    @ReadLog BIT = NULL,
    @DeleteLog BIT = NULL,
    @CreateManufacturer BIT = NULL,
    @ReadManufacturer BIT = NULL,
    @UpdateManufacturer BIT = NULL,
    @DeleteManufacturer BIT = NULL,
    @CreateProduct BIT = NULL,
    @ReadProduct BIT = NULL,
    @UpdateProduct BIT = NULL,
    @DeleteProduct BIT = NULL,
    @CreateProductSet BIT = NULL,
    @ReadProductSet BIT = NULL,
    @UpdateProductSet BIT = NULL,
    @DeleteProductSet BIT = NULL,
    @CreateRole BIT = NULL,
    @ReadRole BIT = NULL,
    @UpdateRole BIT = NULL,
    @DeleteRole BIT = NULL,
    @CreateVendor BIT = NULL,
    @ReadVendor BIT = NULL,
    @UpdateVendor BIT = NULL,
    @DeleteVendor BIT = NULL,
    @FromEndUserRoleCreationDate DATETIME = NULL,
    @ToEndUserRoleCreationDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = 1
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadEndUserRolePermission BIT = (SELECT ReadEndUserRole FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadEndUserRolePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadEndUserRolePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read EndUserRole!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        EndUserRoleID,
        EndUserRoleName,
        CreateAsset,
        ReadAsset,
        UpdateAsset,
        DeleteAsset,
        CreateAssetFix,
        ReadAssetFix,
        UpdateAssetFix,
        DeleteAssetFix,
        CreateAssetIssue,
        ReadAssetIssue,
        UpdateAssetIssue,
        DeleteAssetIssue,
        CreateAssetTransfer,
        ReadAssetTransfer,
        UpdateAssetTransfer,
        DeleteAssetTransfer,
        CreateBuilding,
        ReadBuilding,
        UpdateBuilding,
        DeleteBuilding,
        CreateCategory,
        ReadCategory,
        UpdateCategory,
        DeleteCategory,
        CreateCompany,
        ReadCompany,
        UpdateCompany,
        DeleteCompany,
        CreateDepartment,
        ReadDepartment,
        UpdateDepartment,
        DeleteDepartment,
        CreateEmployee,
        ReadEmployee,
        UpdateEmployee,
        DeleteEmployee,
        CreateEndUser,
        ReadEndUser,
        UpdateEndUser,
        DeleteEndUser,
        CreateEndUserRole,
        ReadEndUserRole,
        UpdateEndUserRole,
        DeleteEndUserRole,
        CreateLocation,
        ReadLocation,
        UpdateLocation,
        DeleteLocation,
        ReadLog,
        DeleteLog,
        CreateManufacturer,
        ReadManufacturer,
        UpdateManufacturer,
        DeleteManufacturer,
        CreateProduct,
        ReadProduct,
        UpdateProduct,
        DeleteProduct,
        CreateProductSet,
        ReadProductSet,
        UpdateProductSet,
        DeleteProductSet,
        CreateRole,
        ReadRole,
        UpdateRole,
        DeleteRole,
        CreateVendor,
        ReadVendor,
        UpdateVendor,
        DeleteVendor,
        EndUserRoleCreationDate
    FROM
        [dbo].[EndUserRole]
    WHERE
        EndUserRoleID = ISNULL(@EndUserRoleID, EndUserRoleID)
        AND EndUserRoleName = ISNULL(@EndUserRoleName, EndUserRoleName)
        AND CreateAsset = ISNULL(@CreateAsset, CreateAsset)
        AND ReadAsset = ISNULL(@ReadAsset, ReadAsset)
        AND UpdateAsset = ISNULL(@UpdateAsset, UpdateAsset)
        AND DeleteAsset = ISNULL(@DeleteAsset, DeleteAsset)
        AND CreateAssetFix = ISNULL(@CreateAssetFix, CreateAssetFix)
        AND ReadAssetFix = ISNULL(@ReadAssetFix, ReadAssetFix)
        AND UpdateAssetFix = ISNULL(@UpdateAssetFix, UpdateAssetFix)
        AND DeleteAssetFix = ISNULL(@DeleteAssetFix, DeleteAssetFix)
        AND CreateAssetIssue = ISNULL(@CreateAssetIssue, CreateAssetIssue)
        AND ReadAssetIssue = ISNULL(@ReadAssetIssue, ReadAssetIssue)
        AND UpdateAssetIssue = ISNULL(@UpdateAssetIssue, UpdateAssetIssue)
        AND DeleteAssetIssue = ISNULL(@DeleteAssetIssue, DeleteAssetIssue)
        AND CreateAssetTransfer = ISNULL(@CreateAssetTransfer, CreateAssetTransfer)
        AND ReadAssetTransfer = ISNULL(@ReadAssetTransfer, ReadAssetTransfer)
        AND UpdateAssetTransfer = ISNULL(@UpdateAssetTransfer, UpdateAssetTransfer)
        AND DeleteAssetTransfer = ISNULL(@DeleteAssetTransfer, DeleteAssetTransfer)
        AND CreateBuilding = ISNULL(@CreateBuilding, CreateBuilding)
        AND ReadBuilding = ISNULL(@ReadBuilding, ReadBuilding)
        AND UpdateBuilding = ISNULL(@UpdateBuilding, UpdateBuilding)
        AND DeleteBuilding = ISNULL(@DeleteBuilding, DeleteBuilding)
        AND CreateCategory = ISNULL(@CreateCategory, CreateCategory)
        AND ReadCategory = ISNULL(@ReadCategory, ReadCategory)
        AND UpdateCategory = ISNULL(@UpdateCategory, UpdateCategory)
        AND DeleteCategory = ISNULL(@DeleteCategory, DeleteCategory)
        AND CreateCompany = ISNULL(@CreateCompany, CreateCompany)
        AND ReadCompany = ISNULL(@ReadCompany, ReadCompany)
        AND UpdateCompany = ISNULL(@UpdateCompany, UpdateCompany)
        AND DeleteCompany = ISNULL(@DeleteCompany, DeleteCompany)
        AND CreateDepartment = ISNULL(@CreateDepartment, CreateDepartment)
        AND ReadDepartment = ISNULL(@ReadDepartment, ReadDepartment)
        AND UpdateDepartment = ISNULL(@UpdateDepartment, UpdateDepartment)
        AND DeleteDepartment = ISNULL(@DeleteDepartment, DeleteDepartment)
        AND CreateEmployee = ISNULL(@CreateEmployee, CreateEmployee)
        AND ReadEmployee = ISNULL(@ReadEmployee, ReadEmployee)
        AND UpdateEmployee = ISNULL(@UpdateEmployee, UpdateEmployee)
        AND DeleteEmployee = ISNULL(@DeleteEmployee, DeleteEmployee)
        AND CreateEndUser = ISNULL(@CreateEndUser, CreateEndUser)
        AND ReadEndUser = ISNULL(@ReadEndUser, ReadEndUser)
        AND UpdateEndUser = ISNULL(@UpdateEndUser, UpdateEndUser)
        AND DeleteEndUser = ISNULL(@DeleteEndUser, DeleteEndUser)
        AND CreateEndUserRole = ISNULL(@CreateEndUserRole, CreateEndUserRole)
        AND ReadEndUserRole = ISNULL(@ReadEndUserRole, ReadEndUserRole)
        AND UpdateEndUserRole = ISNULL(@UpdateEndUserRole, UpdateEndUserRole)
        AND DeleteEndUserRole = ISNULL(@DeleteEndUserRole, DeleteEndUserRole)
        AND CreateLocation = ISNULL(@CreateLocation, CreateLocation)
        AND ReadLocation = ISNULL(@ReadLocation, ReadLocation)
        AND UpdateLocation = ISNULL(@UpdateLocation, UpdateLocation)
        AND DeleteLocation = ISNULL(@DeleteLocation, DeleteLocation)
        AND ReadLog = ISNULL(@ReadLog, @ReadLog)
        AND DeleteLog = ISNULL(@DeleteLog, @DeleteLog)
        AND CreateManufacturer = ISNULL(@CreateManufacturer, CreateManufacturer)
        AND ReadManufacturer = ISNULL(@ReadManufacturer, ReadManufacturer)
        AND UpdateManufacturer = ISNULL(@UpdateManufacturer, UpdateManufacturer)
        AND DeleteManufacturer = ISNULL(@DeleteManufacturer, DeleteManufacturer)
        AND CreateProduct = ISNULL(@CreateProduct, CreateProduct)
        AND ReadProduct = ISNULL(@ReadProduct, ReadProduct)
        AND UpdateProduct = ISNULL(@UpdateProduct, UpdateProduct)
        AND DeleteProduct = ISNULL(@DeleteProduct, DeleteProduct)
        AND CreateProductSet = ISNULL(@CreateProductSet, CreateProductSet)
        AND ReadProductSet = ISNULL(@ReadProductSet, ReadProductSet)
        AND UpdateProductSet = ISNULL(@UpdateProductSet, UpdateProductSet)
        AND DeleteProductSet = ISNULL(@DeleteProductSet, DeleteProductSet)
        AND CreateRole = ISNULL(@CreateRole, CreateRole)
        AND ReadRole = ISNULL(@ReadRole, ReadRole)
        AND UpdateRole = ISNULL(@UpdateRole, UpdateRole)
        AND DeleteRole = ISNULL(@DeleteRole, DeleteRole)
        AND CreateVendor = ISNULL(@CreateVendor, CreateVendor)
        AND ReadVendor = ISNULL(@ReadVendor, ReadVendor)
        AND UpdateVendor = ISNULL(@UpdateVendor, UpdateVendor)
        AND DeleteVendor = ISNULL(@DeleteVendor, DeleteVendor)
        AND ISNULL(@FromEndUserRoleCreationDate, EndUserRoleCreationDate) <= EndUserRoleCreationDate
        AND EndUserRoleCreationDate <= ISNULL(@ToEndUserRoleCreationDate, EndUserRoleCreationDate)
    ORDER BY
        CASE WHEN @NewestRowsFirst = 1 THEN EndUserRoleNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN EndUserRoleNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
