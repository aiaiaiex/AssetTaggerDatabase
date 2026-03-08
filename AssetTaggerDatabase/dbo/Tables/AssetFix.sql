CREATE TABLE [dbo].[AssetFix] (
    [AssetFixID] UNIQUEIDENTIFIER CONSTRAINT [DF_AssetFix_AssetFixID] DEFAULT (NEWID()) NOT NULL,
    [AssetIssueID] UNIQUEIDENTIFIER NOT NULL,
    [AssetFixDateStart] DATETIME CONSTRAINT [DF_AssetFix_AssetFixDateStart] DEFAULT (GETDATE()) NOT NULL,
    [AssetFixCost] MONEY NULL,
    [AssetFixDateEnd] DATETIME NULL,
    [AssetFixTitle] NVARCHAR(50) NOT NULL,
    [AssetFixDescription] NVARCHAR(MAX) NULL,
    [AssetFixed] BIT NOT NULL,
    [EmployeeID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AssetFix] PRIMARY KEY CLUSTERED ([AssetFixID] ASC),
    CONSTRAINT [CK_AssetFix_AssetFixCost] CHECK ([AssetFixCost] >= (0)),
    CONSTRAINT [CK_AssetFix_AssetFixTitle_NoTrailingSpace] CHECK ([AssetFixTitle] NOT LIKE ' %' AND [AssetFixTitle] NOT LIKE '% '),
    CONSTRAINT [CK_AssetFix_AssetFixDescription_NoTrailingSpace] CHECK ([AssetFixDescription] NOT LIKE ' %' AND [AssetFixDescription] NOT LIKE '% '),
    CONSTRAINT [CTK_AssetFix_AssetFixDateEnd_AssetFixDateStart] CHECK ([AssetFixDateEnd] >= [AssetFixDateStart]),
    CONSTRAINT [FK_AssetFix_AssetIssue] FOREIGN KEY ([AssetIssueID]) REFERENCES [dbo].[AssetIssue] ([AssetIssueID]),
    CONSTRAINT [FK_AssetFix_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
);
