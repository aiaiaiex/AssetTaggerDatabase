CREATE PROCEDURE [dbo].[usp_DeleteDepartment]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @DepartmentID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteDepartment BIT = (SELECT DeleteDepartment FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteDepartment IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteDepartment = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete a Department!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Department]
    OUTPUT
        DELETED.DepartmentID,
        DELETED.DepartmentName,
        DELETED.DepartmentInsertDate
    FROM
        [dbo].[Department]
    WHERE
        DepartmentID = @DepartmentID;
END;
