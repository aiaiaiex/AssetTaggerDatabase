CREATE PROCEDURE [dbo].[usp_ReadProductSet]
    @CallingEndUserId UNIQUEIDENTIFIER,
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

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingProductSetPermission BIT = (SELECT HasReadingProductSetPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingProductSetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingProductSetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read ProductSet!', 11, 0);
            RETURN -1;
        END;

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
