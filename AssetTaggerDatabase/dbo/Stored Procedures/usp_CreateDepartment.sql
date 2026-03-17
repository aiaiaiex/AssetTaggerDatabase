CREATE PROCEDURE [dbo].[usp_CreateDepartment]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @DepartmentName NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateDepartment BIT = (SELECT CreateDepartment FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateDepartment IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateDepartment = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Department!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Department] (
        DepartmentName
    )
    OUTPUT
        INSERTED.DepartmentID,
        INSERTED.DepartmentName,
        INSERTED.DepartmentInsertDate
    VALUES (
        @DepartmentName
    );
END;
