CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER = NULL,
    @Username NVARCHAR(850) = NULL,
    @EndUserRoleId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    @FromCreatedAt DATETIME2(3) = NULL,
    @ToCreatedAt DATETIME2(3) = NULL,
    @RowsToSkip NVARCHAR(10) = '',
    @RowsToReturn NVARCHAR(10) = '',
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @HasReadingEndUserPermission BIT = (SELECT HasReadingEndUserPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasReadingEndUserPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasReadingEndUserPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to read EndUser!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        Id,
        Username,
        EndUserRoleId,
        EmployeeId,
        CreatedAt
    FROM
        [dbo].[EndUser]
    WHERE
        Id = COALESCE(@Id, Id)
        AND (Username = COALESCE(@Username, Username) OR Username LIKE @Username)
        AND EndUserRoleId = COALESCE(@EndUserRoleId, EndUserRoleId)
        AND EmployeeId = COALESCE(@EmployeeId, EmployeeId)
        AND COALESCE(@FromCreatedAt, CreatedAt) <= CreatedAt
        AND CreatedAt <= COALESCE(@ToCreatedAt, CreatedAt)
    ORDER BY
        CASE WHEN COALESCE(@NewestRowsFirst, 1) = 1 THEN RowNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RowNumber END ASC
        OFFSET [dbo].[udf_GetRowsToSkipInInt](@RowsToSkip) ROWS
        FETCH NEXT [dbo].[udf_GetRowsToReturnInInt](@RowsToReturn) ROWS ONLY;
END;
