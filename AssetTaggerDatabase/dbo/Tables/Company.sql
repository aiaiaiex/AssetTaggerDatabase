CREATE TABLE [dbo].[Company] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Company_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Company_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Company_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Company_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Company_Name_Exclude] CHECK ([Name] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Company_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% '),

    [Address] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Company_Address] UNIQUE ([Address]),
    CONSTRAINT [CK_Company_Address_Exclude] CHECK ([Address] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Company_Address_NoLeadingAndTrailingWhitespace] CHECK ([Address] NOT LIKE ' %' AND [Address] NOT LIKE '% '),

    [Code] NVARCHAR(5) NOT NULL,
    CONSTRAINT [AK_Company_Code] UNIQUE ([Code]),
    CONSTRAINT [CK_Company_Code_Exclude] CHECK ([Code] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Company_Code_NoLeadingAndTrailingWhitespace] CHECK ([Code] NOT LIKE ' %' AND [Code] NOT LIKE '% '),

    -- Nullable columns.
    [ParentCompanyId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [CTK_Company_Id_ParentCompanyId] CHECK ([Id] <> [ParentCompanyId]),
    CONSTRAINT [FK_Company_Company] FOREIGN KEY ([ParentCompanyId]) REFERENCES [dbo].[Company] ([Id])
);
