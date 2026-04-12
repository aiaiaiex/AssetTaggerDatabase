CREATE PROCEDURE [dbo].[usp_ReadLocation]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER = NULL,
    @Address NVARCHAR(842) = NULL,
    @BuildingId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @RowOrder NVARCHAR(4) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Read', 'Location';

    -- Set final values.
    SET @RowOrder = [dbo].[udf_GetRowOrder](@RowOrder);

    -- Run actual query.
    SELECT
        Id,
        Address,
        BuildingId,
        CreatedAt
    FROM
        [dbo].[Location]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (Address = COALESCE(@Address, Address) OR Address LIKE @Address)
        AND BuildingId = COALESCE(@BuildingId, BuildingId)
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN (@RowOrder = 'DESC') THEN RowNumber END DESC,
        CASE WHEN (@RowOrder = 'ASC') THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
