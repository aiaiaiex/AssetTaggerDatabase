CREATE TABLE [dbo].[Category] (
    [CategoryID] UNIQUEIDENTIFIER CONSTRAINT [DF_Category_CategoryID] DEFAULT (NEWID()) NOT NULL,
    [CategoryName] NVARCHAR(4000) NOT NULL,
    [CategoryInsertDate] DATETIME CONSTRAINT [DF_Category_CategoryInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_Category_CategoryName] UNIQUE ([CategoryName]),
    CONSTRAINT [CK_Category_CategoryName_Exclude] CHECK ([CategoryName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Category_CategoryName_MinimumLength] CHECK (LEN([CategoryName]) > 0),
    CONSTRAINT [CK_Category_CategoryName_NoTrailingSpace] CHECK ([CategoryName] NOT LIKE ' %' AND [CategoryName] NOT LIKE '% '),
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
