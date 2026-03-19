CREATE PROCEDURE [dbo].[usp_ReadDepartment]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @DepartmentID UNIQUEIDENTIFIER = NULL,
    @DepartmentName NVARCHAR(850) = NULL,
    @FromDepartmentInsertDate DATETIME = NULL,
    @ToDepartmentInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadDepartment BIT = (SELECT ReadDepartment FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadDepartment IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@ReadDepartment = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Department!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    SELECT
        DepartmentID,
        DepartmentName,
        DepartmentInsertDate
    FROM
        [dbo].[Department]
    WHERE
        DepartmentID = ISNULL(@DepartmentID, DepartmentID)
        AND (DepartmentName = ISNULL(@DepartmentName, DepartmentName) OR DepartmentName LIKE @DepartmentName)
        AND ISNULL(@FromDepartmentInsertDate, DepartmentInsertDate) <= DepartmentInsertDate
        AND DepartmentInsertDate <= ISNULL(@ToDepartmentInsertDate, DepartmentInsertDate)
    ORDER BY
        CASE WHEN ISNULL(@NewestRowsFirst, 1) = 1 THEN DepartmentNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN DepartmentNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END;
