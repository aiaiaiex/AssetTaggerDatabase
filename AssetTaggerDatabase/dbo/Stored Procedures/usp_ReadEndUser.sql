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

    -- Validate input.
    IF (@EndUserID IS NOT NULL AND (@EndUserName IS NOT NULL OR @EndUserRoleID IS NOT NULL OR @EmployeeID IS NOT NULL OR @GetOnlyNonNullEndUserRoleID = 1 OR @GetOnlyNonNullEmployeeID = 1 OR @GetOnlyNonNullEndUserRoleID = 1 OR @GetOnlyNonNullEmployeeID = 1))
        BEGIN
            RAISERROR ('Cannot get row with unique @EndUserID when non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END

    IF (@GetOnlyNullEndUserRoleID = 1 AND @EndUserRoleID IS NOT NULL)
        BEGIN
            RAISERROR ('Cannot get rows with null EndUserRoleID when @EndUserRoleID is not null!', 11, 0);
            RETURN -1;
        END

    IF (@GetOnlyNonNullEndUserRoleID = 1 AND @EndUserRoleID IS NOT NULL)
        BEGIN
            RAISERROR ('Cannot get all rows with non-null EndUserRoleID when @EndUserRoleID is not null!', 11, 0);
            RETURN -1;
        END

    IF (@GetOnlyNullEndUserRoleID = 1 AND @GetOnlyNonNullEndUserRoleID = 1)
        BEGIN
            RAISERROR ('@GetOnlyNullEndUserRoleID and @GetOnlyNonNullEndUserRoleID cannot be both 1!', 11, 0);
            RETURN -1;
        END

    IF (@GetOnlyNullEmployeeID = 1 AND @EmployeeID IS NOT NULL)
        BEGIN
            RAISERROR ('Cannot get rows with null EmployeeID when @EmployeeID is not null!', 11, 0);
            RETURN -1;
        END

    IF (@GetOnlyNonNullEmployeeID = 1 AND @EmployeeID IS NOT NULL)
        BEGIN
            RAISERROR ('Cannot get all rows with non-null EmployeeID when @EmployeeID is not null!', 11, 0);
            RETURN -1;
        END

    IF (@GetOnlyNullEmployeeID = 1 AND @GetOnlyNonNullEmployeeID = 1)
        BEGIN
            RAISERROR ('@GetOnlyNullEmployeeID and @GetOnlyNonNullEmployeeID cannot be both 1!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
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
    WHERE EndUserID = ISNULL(@EndUserID, EndUserID) AND EndUserName = ISNULL(@EndUserName, EndUserName) AND EndUserRoleID IS NOT DISTINCT FROM IIF(@GetOnlyNonNullEndUserRoleID = 1, ISNULL(EndUserRoleID, '00000000-0000-0000-0000-000000000000'), IIF(@GetOnlyNullEndUserRoleID = 1, NULL, ISNULL(@EndUserRoleID, EndUserRoleID))) AND EmployeeID IS NOT DISTINCT FROM IIF(@GetOnlyNonNullEmployeeID = 1, ISNULL(EmployeeID, '00000000-0000-0000-0000-000000000000'), IIF(@GetOnlyNullEmployeeID = 1, NULL, ISNULL(@EmployeeID, EmployeeID)));

END
