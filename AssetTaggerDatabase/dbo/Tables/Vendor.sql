CREATE TABLE [dbo].[Vendor] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Vendor_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Vendor_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Vendor] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Vendor_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Vendor_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Vendor_Name_Exclude] CHECK ([Name] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Vendor_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% '),

    [Address] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Vendor_Address] UNIQUE ([Address]),
    CONSTRAINT [CK_Vendor_Address_Exclude] CHECK ([Address] NOT IN ('', 'NULL')),
    CONSTRAINT [CK_Vendor_Address_NoLeadingAndTrailingWhitespace] CHECK ([Address] NOT LIKE ' %' AND [Address] NOT LIKE '% ')
);
