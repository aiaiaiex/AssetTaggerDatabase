CREATE PROCEDURE [dbo].[usp_ReadProduct]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER = NULL,
    @Name NVARCHAR(421) = '',
    @ModelNumber NVARCHAR(421) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @ManufacturerId NVARCHAR(36) = '',
    @CategoryId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @RowOrder NVARCHAR(4) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Product';

    -- Set final values.
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        Id,
        Name,
        ModelNumber,
        DocumentationUrl,
        ManufacturerId,
        CategoryId,
        CreatedAt
    FROM
        [dbo].[Product]
    WHERE
        Id = COALESCE(@Id, Id)
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@Name, Name) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@ModelNumber, ModelNumber) = 1
        AND [dbo].[udf_IsEqualToOrLikeNvarcharColumn](@DocumentationUrl, DocumentationUrl) = 1
        AND [dbo].[udf_IsEqualToUniqueIdentifierColumn](@ManufacturerId, ManufacturerId) = 1
        AND CategoryId = COALESCE(@CategoryId, CategoryId)
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN (@RowOrder = 'DESC') THEN RowNumber END DESC,
        CASE WHEN (@RowOrder = 'ASC') THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
