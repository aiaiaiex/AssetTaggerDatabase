CREATE PROCEDURE [dbo].[usp_DeleteStoredProcedureLog]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingStoredProcedureLogPermission BIT = (SELECT HasDeletingStoredProcedureLogPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingStoredProcedureLogPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingStoredProcedureLogPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete a Log!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[StoredProcedureLog]
    OUTPUT
        DELETED.Id,
        DELETED.EndUserId,
        DELETED.EndUserIpAddress,
        DELETED.StartedAt,
        DELETED.EndedAt,
        DELETED.ExecutionTimeInMilliseconds,
        DELETED.HasExecutedSuccessfully,
        DELETED.Name,
        DELETED.Arguments
    FROM
        [dbo].[StoredProcedureLog]
    WHERE
        Id = @Id;
END;
