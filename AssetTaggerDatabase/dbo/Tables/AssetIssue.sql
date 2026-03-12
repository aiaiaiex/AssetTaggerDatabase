CREATE TABLE [dbo].[AssetIssue] (
    [AssetIssueNumber] INT IDENTITY (1, 1),
    [AssetIssueID] UNIQUEIDENTIFIER CONSTRAINT [DF_AssetIssue_AssetIssueID] DEFAULT (NEWID()) NOT NULL,
    [AssetIssueTitle] NVARCHAR(4000) NOT NULL,
    [AssetIssueDescription] NVARCHAR(MAX) NULL,
    [AssetIssueDate] DATETIME CONSTRAINT [DF_AssetIssue_AssetIssueDate] DEFAULT (GETDATE()) NOT NULL,
    [AssetID] UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [AK_AssetIssue_AssetIssueNumber] UNIQUE CLUSTERED ([AssetIssueNumber] ASC),
    CONSTRAINT [PK_AssetIssue] PRIMARY KEY NONCLUSTERED ([AssetIssueID] ASC),
    CONSTRAINT [CK_AssetIssue_AssetIssueTitle_Exclude] CHECK ([AssetIssueTitle] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_AssetIssue_AssetIssueTitle_MinimumLength] CHECK (LEN([AssetIssueTitle]) > 0),
    CONSTRAINT [CK_AssetIssue_AssetIssueTitle_NoLeadingAndTrailingWhitespace] CHECK ([AssetIssueTitle] NOT LIKE ' %' AND [AssetIssueTitle] NOT LIKE '% '),
    CONSTRAINT [CK_AssetIssue_AssetIssueDescription_Exclude] CHECK ([AssetIssueDescription] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_AssetIssue_AssetIssueDescription_MinimumLength] CHECK (LEN([AssetIssueDescription]) > 0),
    CONSTRAINT [CK_AssetIssue_AssetIssueDescription_NoLeadingAndTrailingWhitespace] CHECK ([AssetIssueDescription] NOT LIKE ' %' AND [AssetIssueDescription] NOT LIKE '% '),
    CONSTRAINT [FK_AssetIssue_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]),
    CONSTRAINT [FK_AssetIssue_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
);
