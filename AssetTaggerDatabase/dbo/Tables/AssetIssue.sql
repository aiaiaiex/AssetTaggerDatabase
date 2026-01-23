CREATE TABLE [dbo].[AssetIssue] (
    [AssetIssueID]    UNIQUEIDENTIFIER CONSTRAINT [DF_AssetIssues_AssetIssueID] DEFAULT (newid()) NOT NULL,
    [AssetIssueTitle] NVARCHAR (50)    NOT NULL,
    [AssetIssueDesc]  NTEXT            NULL,
    [AssetIssueDate]  DATETIME         NULL,
    [AssetID]         UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AssetIssues] PRIMARY KEY CLUSTERED ([AssetIssueID] ASC),
    CONSTRAINT [FK_AssetIssues_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]),
    CONSTRAINT [FK_AssetIssues_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
);

