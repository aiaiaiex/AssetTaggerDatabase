CREATE TABLE [dbo].[Building] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Building_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Building_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Building] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Building_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Foreign keys.
    [CompanyId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Building_Company] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]),

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Building_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Building_Name_Exclude] CHECK ([Name] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Building_Name_MinimumLength] CHECK (LEN([Name]) > 0),
    CONSTRAINT [CK_Building_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% '),

    [Address] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Building_Address] UNIQUE ([Address]),
    CONSTRAINT [CK_Building_Address_Exclude] CHECK ([Address] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Building_Address_MinimumLength] CHECK (LEN([Address]) > 0),
    CONSTRAINT [CK_Building_Address_NoLeadingAndTrailingWhitespace] CHECK ([Address] NOT LIKE ' %' AND [Address] NOT LIKE '% ')
);
