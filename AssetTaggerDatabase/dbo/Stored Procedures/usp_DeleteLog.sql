CREATE PROCEDURE [dbo].[usp_DeleteLog]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @LogID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingLogPermission BIT = (SELECT HasDeletingLogPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingLogPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingLogPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Log!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Log]
    OUTPUT
        DELETED.LogID,
        DELETED.EndUserID,
        DELETED.LogEndUserIP,
        DELETED.LogStoredProcedureStart,
        DELETED.LogStoredProcedureEnd,
        DELETED.LogStoredProcedureMilliseconds,
        DELETED.LogStoredProcedureSuccess,
        DELETED.LogStoredProcedureName,
        DELETED.LogStoredProcedureParameters
    FROM
        [dbo].[Log]
    WHERE
        LogID = @LogID;
END;
