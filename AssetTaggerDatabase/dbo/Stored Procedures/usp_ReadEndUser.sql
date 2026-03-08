CREATE PROCEDURE [dbo].[usp_ReadEndUser]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EndUserID UNIQUEIDENTIFIER = NULL,
    @EndUserName NVARCHAR(4000) = NULL,
    @EndUserRoleID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL
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

    -- Validate input.
    IF (@EndUserID IS NOT NULL AND (@EndUserName IS NOT NULL OR @EndUserRoleID IS NOT NULL OR @EmployeeID IS NOT NULL))
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
    WHERE EndUserID = ISNULL(@EndUserID, EndUserID) AND EndUserName = ISNULL(@EndUserName, EndUserName) AND EndUserRoleID = ISNULL(@EndUserRoleID, EndUserRoleID) AND EmployeeID = ISNULL(@EmployeeID, EmployeeID);
END
