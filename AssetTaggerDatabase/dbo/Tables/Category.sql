CREATE TABLE [dbo].[Category] (
    [CategoryID] UNIQUEIDENTIFIER CONSTRAINT [DF_Category_CategoryID] DEFAULT (NEWID()) NOT NULL,
    [CategoryName] NVARCHAR(50) NOT NULL,
    CONSTRAINT [AK_Category_CategoryName] UNIQUE ([CategoryName]),
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
