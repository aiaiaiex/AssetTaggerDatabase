CREATE PROCEDURE [dbo].[usp_ReadProduct]
    @CallingEndUserId UNIQUEIDENTIFIER,
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
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingProductPermission BIT = (SELECT HasReadingProductPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingProductPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingProductPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Product!', 11, 0);
            RETURN -1;
        END;

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
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
