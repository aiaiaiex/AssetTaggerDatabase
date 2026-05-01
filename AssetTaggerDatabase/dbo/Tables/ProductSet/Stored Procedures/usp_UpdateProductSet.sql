CREATE PROCEDURE [dbo].[usp_UpdateProductSet]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @ProductQuantity NVARCHAR(19) = '',
    -- Non-nullable foreign keys.
    @ParentProductId NVARCHAR(36),
    @ProductId NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@ProductQuantity = ''', [dbo].[udf_ConvertNullToNvarchar](@ProductQuantity), ''', ',
        -- Non-nullable foreign keys.
        '@ParentProductId = ''', [dbo].[udf_ConvertNullToNvarchar](@ParentProductId), ''', ',
        '@ProductId = ''', [dbo].[udf_ConvertNullToNvarchar](@ProductId), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Update';
    DECLARE @TableName NVARCHAR(836) = 'ProductSet';
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
        UPDATE
            [dbo].[ProductSet]
        SET
            ProductQuantity = [dbo].[udf_GetDefaultBigint](@ProductQuantity, ProductQuantity)
        OUTPUT
        -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.ProductQuantity,
            -- Non-nullable foreign keys.
            INSERTED.ParentProductId,
            INSERTED.ProductId,
            -- Old values.
            -- Non-nullable columns with default values.
            DELETED.ProductQuantity AS OldProductQuantity
        FROM
            [dbo].[ProductSet]
        WHERE
            ParentProductId = [dbo].[udf_GetDefaultUniqueidentifier](@ParentProductId, NULL)
            AND ProductId = [dbo].[udf_GetDefaultUniqueidentifier](@ProductId, ProductId);
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
