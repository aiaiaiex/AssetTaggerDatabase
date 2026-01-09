CREATE TABLE [dbo].[Category] (
    [CategoryID]   UNIQUEIDENTIFIER NOT NULL,
    [CategoryName] NVARCHAR (50)    NOT NULL
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Category_CategoryName]
    ON [dbo].[Category]([CategoryName] ASC);
GO

ALTER TABLE [dbo].[Category]
    ADD CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CategoryID] ASC);
GO

