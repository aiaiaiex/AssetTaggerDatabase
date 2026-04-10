CREATE TABLE [dbo].[Role] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Role_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Role_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Role_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Role_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Role_Name_Exclude] CHECK ([Name] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Role_Name_MinimumLength] CHECK (LEN([Name]) > 0),
    CONSTRAINT [CK_Role_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% ')
);
