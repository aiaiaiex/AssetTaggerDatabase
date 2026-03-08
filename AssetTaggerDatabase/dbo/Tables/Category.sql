CREATE TABLE [dbo].[Category] (
    [CategoryID] UNIQUEIDENTIFIER CONSTRAINT [DF_Category_CategoryID] DEFAULT (NEWID()) NOT NULL,
    [CategoryName] NVARCHAR(50) NOT NULL,
    CONSTRAINT [AK_Category_CategoryName] UNIQUE ([CategoryName]),
    CONSTRAINT [CK_Category_CategoryName_MinimumLength] CHECK (LEN([CategoryName]) > 0),
    CONSTRAINT [CK_Category_CategoryName_NoTrailingSpace] CHECK ([CategoryName] NOT LIKE ' %' AND [CategoryName] NOT LIKE '% '),
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
