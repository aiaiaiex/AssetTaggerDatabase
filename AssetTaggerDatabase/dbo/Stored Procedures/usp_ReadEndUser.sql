CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @EndUserID UNIQUEIDENTIFIER = NULL,
    @EndUserName NVARCHAR(50) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @EmployeeID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
AS
BEGIN
    SET NOCOUNT ON;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER;
    SELECT @NULLISH_UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);

    DECLARE @NON_NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER;
    SELECT @NON_NULLISH_UNIQUEIDENTIFIER = (SELECT NON_NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NonNullishConstants]);

    -- Validate input.
    IF (@EndUserID IS NOT NULL AND (@EndUserName IS NOT NULL OR @EndUserRoleID != @NULLISH_UNIQUEIDENTIFIER OR @EmployeeID != @NULLISH_UNIQUEIDENTIFIER))
        BEGIN
            RAISERROR ('Cannot get row with unique @EndUserID when non-default values are passed to other parameters!', 11, 0);
            RETURN -1;
        END

    -- Run actual query.
    SELECT
        EndUserID,
        EndUserName,
        EndUserRoleID,
        EmployeeID
    FROM [dbo].[EndUser]
    -- @NON_NULLISH_UNIQUEIDENTIFIER (11111111-1111-1111-1111-111111111111) will never be equal to NEWID() because NEWID() complies with RFC4122 which should always include the version number in the generated UNIQUEIDENTIFIER which can't be 1 because the version number of random UUIDs is 4.
    -- See more:
    -- https://learn.microsoft.com/en-us/sql/t-sql/functions/newid-transact-sql
    -- https://datatracker.ietf.org/doc/html/rfc4122#section-4.1.3
    WHERE EndUserID = ISNULL(@EndUserID, EndUserID) AND EndUserName = ISNULL(@EndUserName, EndUserName) AND EndUserRoleID IS NOT DISTINCT FROM IIF(@EndUserRoleID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(EndUserRoleID, @NON_NULLISH_UNIQUEIDENTIFIER), IIF(@EndUserRoleID = @NULLISH_UNIQUEIDENTIFIER, EndUserRoleID, @EndUserRoleID)) AND EmployeeID IS NOT DISTINCT FROM IIF(@EmployeeID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(EmployeeID, @NON_NULLISH_UNIQUEIDENTIFIER), IIF(@EmployeeID = @NULLISH_UNIQUEIDENTIFIER, EmployeeID, @EmployeeID));
END
