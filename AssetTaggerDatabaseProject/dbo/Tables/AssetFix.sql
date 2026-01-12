CREATE TABLE [dbo].[AssetFix] (
    [AssetFixID]        UNIQUEIDENTIFIER NOT NULL,
    [AssetIssueID]      UNIQUEIDENTIFIER NOT NULL,
    [AssetFixDateStart] DATETIME         NULL,
    [AssetFixCost]      MONEY            NULL,
    [AssetFixDateEnd]   DATETIME         NULL,
    [AssetFixTitle]     NVARCHAR (50)    NOT NULL,
    [AssetFixDesc]      NTEXT            NULL,
    [AssetFixed]        BIT              NOT NULL,
    [EmployeeID]        UNIQUEIDENTIFIER NOT NULL
);
GO

ALTER TABLE [dbo].[AssetFix]
    ADD CONSTRAINT [DEFAULT_AssetFIx_AssetFixID] DEFAULT (newid()) FOR [AssetFixID];
GO

ALTER TABLE [dbo].[AssetFix]
    ADD CONSTRAINT [PK_AssetFIx] PRIMARY KEY CLUSTERED ([AssetFixID] ASC);
GO

ALTER TABLE [dbo].[AssetFix]
    ADD CONSTRAINT [FK_AssetFIx_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID]);
GO

ALTER TABLE [dbo].[AssetFix]
    ADD CONSTRAINT [FK_AssetFix_AssetIssue] FOREIGN KEY ([AssetIssueID]) REFERENCES [dbo].[AssetIssue] ([AssetIssueID]);
GO

