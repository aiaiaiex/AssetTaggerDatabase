CREATE TABLE [dbo].[Category] (
    [CategoryID]   UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Category_CategoryID] DEFAULT (newid()) NOT NULL,
    [CategoryName] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Category_CategoryName]
    ON [dbo].[Category]([CategoryName] ASC);
GO

