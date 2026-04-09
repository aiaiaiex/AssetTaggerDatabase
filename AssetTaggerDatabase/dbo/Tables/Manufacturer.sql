CREATE TABLE [dbo].[Manufacturer] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Manufacturer_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Manufacturer_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Manufacturer] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIMEOFFSET(3) CONSTRAINT [DF_Manufacturer_CreatedAt] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Manufacturer_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Manufacturer_Name_Exclude] CHECK ([Name] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Manufacturer_Name_MinimumLength] CHECK (LEN([Name]) > 0),
    CONSTRAINT [CK_Manufacturer_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% ')
);
