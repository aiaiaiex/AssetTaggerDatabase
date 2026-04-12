CREATE PROCEDURE [dbo].[usp_ReadProductSet]
    @CallingEndUserId NVARCHAR(36),
    @ParentProductId UNIQUEIDENTIFIER = NULL,
    @ProductId UNIQUEIDENTIFIER = NULL,
    @FromProductQuantity INT = NULL,
    @ToProductQuantity INT = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'ProductSet';

    -- Run actual query.
    SELECT
        ParentProductId,
        ProductId,
        ProductQuantity,
        CreatedAt
    FROM
        [dbo].[ProductSet]
    WHERE
        ParentProductId = COALESCE(@ParentProductId, ParentProductId)
        AND ProductId = COALESCE(@ProductId, ProductId)
        AND COALESCE(@FromProductQuantity, ProductQuantity) <= ProductQuantity
        AND ProductQuantity <= COALESCE(@ToProductQuantity, ProductQuantity)
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
