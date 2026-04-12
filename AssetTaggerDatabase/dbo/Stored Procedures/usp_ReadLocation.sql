CREATE PROCEDURE [dbo].[usp_ReadLocation]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Address NVARCHAR(842) = NULL,
    @BuildingId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingLocationPermission BIT = (SELECT HasReadingLocationPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingLocationPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingLocationPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read Location!', 11, 0);
            RETURN -1;
        END;

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
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
