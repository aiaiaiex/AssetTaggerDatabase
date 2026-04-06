CREATE TABLE [dbo].[Category] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Category_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Category_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [CreatedAt] DATETIMEOFFSET(3) CONSTRAINT [DF_Category_CreatedAt] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Category_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Category_Name_Exclude] CHECK ([Name] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Category_Name_MinimumLength] CHECK (LEN([Name]) > 0),
    CONSTRAINT [CK_Category_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% ')
);
