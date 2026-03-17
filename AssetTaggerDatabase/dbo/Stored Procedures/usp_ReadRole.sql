CREATE PROCEDURE [dbo].[usp_ReadRole]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @RoleID UNIQUEIDENTIFIER = NULL,
    @RoleName NVARCHAR(850) = NULL,
    @FromRoleInsertDate DATETIME = NULL,
    @ToRoleInsertDate DATETIME = NULL,
    @RowsToSkip INT = NULL,
    @RowsToReturn INT = NULL,
    @NewestRowsFirst BIT = NULL -- Defaults to 1 when NULL.
AS
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadRole BIT;
    SELECT @ReadRole = (SELECT ReadRole FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadRole IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@ReadRole = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read Role!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    SELECT
        RoleID,
        RoleName,
        RoleInsertDate
    FROM [dbo].[Role]
    WHERE RoleID = ISNULL(@RoleID, RoleID) AND RoleName = ISNULL(@RoleName, RoleName) AND ISNULL(@FromRoleInsertDate, RoleInsertDate) <= RoleInsertDate AND RoleInsertDate <= ISNULL(@ToRoleInsertDate, RoleInsertDate)
    ORDER BY
        CASE WHEN @NewestRowsFirst IS NULL OR @NewestRowsFirst = 1 THEN RoleNumber END DESC,
        CASE WHEN @NewestRowsFirst = 0 THEN RoleNumber END ASC
        OFFSET ISNULL(@RowsToSkip, 0) ROWS
        -- If @RowsToReturn is NULL fetch the next 2,147,483,647 rows which is the upper limit of INT, the data type of EndUserNumber.
        -- See more:
        -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
        FETCH NEXT ISNULL(@RowsToReturn, 2147483647) ROWS ONLY;
END
