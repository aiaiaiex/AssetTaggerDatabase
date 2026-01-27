CREATE TABLE [dbo].[AssetIssue] (
    [AssetIssueID]    UNIQUEIDENTIFIER CONSTRAINT [DF_AssetIssue_AssetIssueID] DEFAULT (newid()) NOT NULL,
    [AssetIssueTitle] NVARCHAR (50)    NOT NULL,
    [AssetIssueDesc]  NTEXT            NULL,
    [AssetIssueDate]  DATETIME         CONSTRAINT [DF_AssetIssue_AssetIssueDate] DEFAULT (GETDATE()) NOT NULL,
    [AssetID]         UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AssetIssue] PRIMARY KEY CLUSTERED ([AssetIssueID] ASC),
    CONSTRAINT [FK_AssetIssue_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]),
    CONSTRAINT [FK_AssetIssue_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
);

