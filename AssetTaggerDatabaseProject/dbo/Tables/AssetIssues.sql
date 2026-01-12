CREATE TABLE [dbo].[AssetIssues] (
    [AssetIssueID]    UNIQUEIDENTIFIER NOT NULL,
    [AssetIssueTitle] NVARCHAR (50)    NOT NULL,
    [AssetIssueDesc]  NTEXT            NULL,
    [AssetIssueDate]  DATETIME         NULL,
    [AssetID]         UNIQUEIDENTIFIER NOT NULL,
    [EmployeeID]      UNIQUEIDENTIFIER NOT NULL
);
GO

ALTER TABLE [dbo].[AssetIssues]
    ADD CONSTRAINT [DEFAULT_AssetIssues_AssetIssueID] DEFAULT (newid()) FOR [AssetIssueID];
GO

ALTER TABLE [dbo].[AssetIssues]
    ADD CONSTRAINT [FK_AssetIssues_Asset] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[Asset] ([AssetID]);
GO

ALTER TABLE [dbo].[AssetIssues]
    ADD CONSTRAINT [FK_AssetIssues_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]);
GO

ALTER TABLE [dbo].[AssetIssues]
    ADD CONSTRAINT [PK_AssetIssues] PRIMARY KEY CLUSTERED ([AssetIssueID] ASC);
GO

