CREATE PROCEDURE [dbo].[usp_UpdateDepartment]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @DepartmentID UNIQUEIDENTIFIER,
    @DepartmentName NVARCHAR(850) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateDepartment BIT = (SELECT UpdateDepartment FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateDepartment IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@UpdateDepartment = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Department!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Department]
    SET
        DepartmentName = ISNULL(@DepartmentName, DepartmentName)
    OUTPUT
        INSERTED.DepartmentID,
        INSERTED.DepartmentName,
        INSERTED.DepartmentInsertDate,
        DELETED.DepartmentName AS OldDepartmentName
    FROM
        [dbo].[Department]
    WHERE
        DepartmentID = @DepartmentID;
END;
