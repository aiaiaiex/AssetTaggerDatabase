CREATE PROCEDURE [dbo].[usp_DeleteAsset]
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
    DECLARE @TableName NVARCHAR(836) = 'Asset';
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
        DELETE [dbo].[Asset]
        OUTPUT
            -- Non-nullable columns with default values.
            DELETED.CreatedAt,
            DELETED.Id,
            -- Non-nullable foreign keys.
            DELETED.ProductId,
            -- Nullable foreign keys.
            DELETED.EmployeeId,
            DELETED.LocationId,
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
