CREATE PROCEDURE [test_Constraints].[test_DF_EndUser_EndUserID]
AS
BEGIN
    -- Create dummy data for EndUser.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[EndUser]', @Defaults = 1;

    DECLARE @EndUserName NVARCHAR(50) = 'End User Name 01';

    INSERT INTO [dbo].[EndUser] (EndUserName) VALUES
    (@EndUserName);

    -- Actual output.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = EndUserID FROM [dbo].[EndUser];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
