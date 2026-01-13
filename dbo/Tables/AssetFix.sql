CREATE TABLE [dbo].[AssetFix] (
    [AssetFixID]        UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_AssetFix_AssetFixID] DEFAULT (newid()) NOT NULL,
    [AssetIssueID]      UNIQUEIDENTIFIER NOT NULL,
    [AssetFixDateStart] DATETIME         NULL,
    [AssetFixCost]      MONEY            NULL,
    [AssetFixDateEnd]   DATETIME         NULL,
    [AssetFixTitle]     NVARCHAR (50)    NOT NULL,
    [AssetFixDesc]      NTEXT            NULL,
    [AssetFixed]        BIT              NOT NULL,
    [EmployeeID]        UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AssetFix] PRIMARY KEY CLUSTERED ([AssetFixID] ASC),
    CONSTRAINT [FK_AssetFix_AssetIssue] FOREIGN KEY ([AssetIssueID]) REFERENCES [dbo].[AssetIssue] ([AssetIssueID]),
    CONSTRAINT [FK_AssetFix_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
);

