CREATE TABLE [dbo].[Vendor] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Vendor_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Vendor_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Vendor] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Vendor_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Vendor_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Vendor_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Name]) = 1),
    CONSTRAINT [CK_Vendor_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Name]) = 1),

    -- Nullable columns.
    [Address] NVARCHAR(850) NULL,
    CONSTRAINT [CK_Vendor_Address_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Address]) = 1),
    CONSTRAINT [CK_Vendor_Address_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Address]) = 1)
);

CREATE UNIQUE NONCLUSTERED INDEX [IX_Vendor_Address]
    ON [dbo].[Asset] ([Address])
    WHERE [Address] IS NOT NULL;
