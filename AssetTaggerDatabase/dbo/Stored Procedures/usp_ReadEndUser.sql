CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserID UNIQUEIDENTIFIER = NULL,
    @EndUserName NVARCHAR(50) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @EmployeeID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
AS
BEGIN
    SET NOCOUNT ON;

    -- Check reading permission of the calling EndUser.
    DECLARE @ReadEndUser BIT;
    SELECT @ReadEndUser = (SELECT ReadEndUser FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@ReadEndUser IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END
    IF (@ReadEndUser = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to read EndUser!', 11, 0);
            RETURN -1;
        END

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
    WHERE EndUserID = ISNULL(@EndUserID, EndUserID) AND EndUserName = ISNULL(@EndUserName, EndUserName) AND EndUserRoleID IS NOT DISTINCT FROM IIF(@EndUserRoleID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(EndUserRoleID, @NON_NULLISH_UNIQUEIDENTIFIER), IIF(@EndUserRoleID = @NULLISH_UNIQUEIDENTIFIER, EndUserRoleID, @EndUserRoleID)) AND EmployeeID IS NOT DISTINCT FROM IIF(@EmployeeID = @NON_NULLISH_UNIQUEIDENTIFIER, ISNULL(EmployeeID, @NON_NULLISH_UNIQUEIDENTIFIER), IIF(@EmployeeID = @NULLISH_UNIQUEIDENTIFIER, EmployeeID, @EmployeeID));
END
