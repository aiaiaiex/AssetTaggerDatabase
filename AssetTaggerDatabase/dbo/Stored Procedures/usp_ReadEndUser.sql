CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @EndUserID UNIQUEIDENTIFIER = NULL,
    @EndUserName NVARCHAR(50) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @GetOnlyNullEndUserRoleID BIT = 0,
    @GetOnlyNullEmployeeID BIT = 0,
    @GetOnlyNonNullEndUserRoleID BIT = 0,
    @GetOnlyNonNullEmployeeID BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        EndUserID,
        EndUserName,
        EndUserRoleID,
        EmployeeID
    FROM [dbo].[EndUser]
    -- 00000000-0000-0000-0000-000000000000 will never be equal to NEWID() because it complies with RFC4122 which should always include the version number in the generated UNIQUEIDENTIFIER which can't be 0 because the version number starts at 1.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/newid-transact-sql
    -- https://datatracker.ietf.org/doc/html/rfc4122#section-4.1.3
    WHERE ((@EndUserID IS NOT NULL AND @EndUserName IS NULL AND @EndUserRoleID IS NULL AND @EmployeeID IS NULL AND @GetOnlyNullEndUserRoleID = 0 AND @GetOnlyNullEmployeeID = 0 AND @GetOnlyNonNullEndUserRoleID = 0 AND @GetOnlyNonNullEmployeeID = 0) OR @EndUserID IS NULL) AND (((@GetOnlyNullEndUserRoleID = 1 AND @EndUserRoleID IS NULL) OR @GetOnlyNullEndUserRoleID = 0) AND (NOT (@GetOnlyNullEndUserRoleID = 1 AND @GetOnlyNonNullEndUserRoleID = 1) AND NOT (@GetOnlyNullEmployeeID = 1 AND @GetOnlyNonNullEmployeeID = 1)) AND ((@GetOnlyNullEmployeeID = 1 AND @EmployeeID IS NULL) OR @GetOnlyNullEmployeeID = 0)) AND EndUserID = ISNULL(@EndUserID, EndUserID) AND EndUserName = ISNULL(@EndUserName, EndUserName) AND EndUserRoleID IS NOT DISTINCT FROM IIF(@GetOnlyNonNullEndUserRoleID = 1, ISNULL(EndUserRoleID, '00000000-0000-0000-0000-000000000000'), IIF(@GetOnlyNullEndUserRoleID = 1, NULL, ISNULL(@EndUserRoleID, EndUserRoleID))) AND EmployeeID IS NOT DISTINCT FROM IIF(@GetOnlyNonNullEmployeeID = 1, ISNULL(EmployeeID, '00000000-0000-0000-0000-000000000000'), IIF(@GetOnlyNullEmployeeID = 1, NULL, ISNULL(@EmployeeID, EmployeeID)));

END
