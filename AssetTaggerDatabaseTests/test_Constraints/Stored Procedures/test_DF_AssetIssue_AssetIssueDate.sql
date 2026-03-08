CREATE PROCEDURE [test_Constraints].[test_DF_AssetIssue_AssetIssueDate]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[AssetIssue]', @Defaults = 1;

    DECLARE @AssetIssueTitle NVARCHAR(4000) = 'Asset Issue Title 01';

    INSERT INTO [dbo].[AssetIssue] (AssetIssueTitle) VALUES
    (@AssetIssueTitle);

    -- Actual ouput.
    DECLARE @actual DATETIME;
    SELECT @actual = AssetIssueDate FROM [dbo].[AssetIssue];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
