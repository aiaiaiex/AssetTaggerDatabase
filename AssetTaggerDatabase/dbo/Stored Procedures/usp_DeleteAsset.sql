CREATE PROCEDURE [dbo].[usp_DeleteAsset]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Asset';

    -- Run actual query.
    DELETE [dbo].[Asset]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable foreign keys.
        DELETED.EmployeeId,
        DELETED.LocationId,
        DELETED.ProductId,
        -- Nullable foreign keys.
        DELETED.VendorId,
        -- Nullable columns.
        DELETED.DocumentationUrl,
        DELETED.PurchasedAt,
        DELETED.PurchasePrice,
        DELETED.SalvageValue,
        DELETED.SerialNumber,
        DELETED.UsefulLife,
        DELETED.WarrantyDuration,
        DELETED.WarrantyUnitOfMeasure,
        -- Computed columns.
        DELETED.AnnualDepreciationExpense,
        DELETED.CurrentBookValue,
        DELETED.WarrantyExpirationDate
    FROM
        [dbo].[Asset]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
