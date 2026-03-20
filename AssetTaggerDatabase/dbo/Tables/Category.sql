CREATE TABLE [dbo].[Category] (
    [CategoryNumber] INT IDENTITY (1, 1),
    [CategoryID] UNIQUEIDENTIFIER CONSTRAINT [DF_Category_CategoryID] DEFAULT (NEWID()) NOT NULL,
    [CategoryName] NVARCHAR(850) NOT NULL,
    [CategoryInsertDate] DATETIMEOFFSET(3) CONSTRAINT [DF_Category_CategoryInsertDate] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,
    CONSTRAINT [AK_Category_CategoryNumber] UNIQUE CLUSTERED ([CategoryNumber] ASC),
    CONSTRAINT [AK_Category_CategoryName] UNIQUE ([CategoryName]),
    CONSTRAINT [CK_Category_CategoryName_Exclude] CHECK ([CategoryName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Category_CategoryName_MinimumLength] CHECK (LEN([CategoryName]) > 0),
    CONSTRAINT [CK_Category_CategoryName_NoLeadingAndTrailingWhitespace] CHECK ([CategoryName] NOT LIKE ' %' AND [CategoryName] NOT LIKE '% '),
    CONSTRAINT [PK_Category] PRIMARY KEY NONCLUSTERED ([CategoryID] ASC)
);
