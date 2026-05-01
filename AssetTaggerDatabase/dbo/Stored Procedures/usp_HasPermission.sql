CREATE PROCEDURE [dbo].[usp_HasPermission]
    @EndUserId UNIQUEIDENTIFIER,
    @Operation NVARCHAR(6), -- Create, Read, Update, and Delete.
    @TableName NVARCHAR(836)
AS;
BEGIN
    SET NOCOUNT ON;

    DECLARE @RoleId UNIQUEIDENTIFIER = (
        SELECT RoleId
        FROM
            [dbo].[EndUser]
        WHERE
            Id = @EndUserId
    );

    IF (@RoleId IS NULL)
        BEGIN
            RAISERROR ('EndUser does not exist!', 11, 0);
            RETURN -1;
        END;

    DECLARE @PermissionId UNIQUEIDENTIFIER = (
        SELECT Id
        FROM
            [dbo].[Permission]
        WHERE
            RoleId = @RoleId
            AND Operation = @Operation
            AND TableName = @TableName
    );

    IF (@PermissionId IS NULL)
        BEGIN
            RAISERROR ('EndUser has no permission!', 11, 0);
            RETURN -1;
        END;
END;
