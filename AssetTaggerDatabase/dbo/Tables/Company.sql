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
    CONSTRAINT [CK_Company_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Name]) = 1),
    CONSTRAINT [CK_Company_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Name]) = 1),

    [Address] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Company_Address] UNIQUE ([Address]),
    CONSTRAINT [CK_Company_Address_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Address]) = 1),
    CONSTRAINT [CK_Company_Address_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Address]) = 1),

    [Code] NVARCHAR(5) NOT NULL,
    CONSTRAINT [AK_Company_Code] UNIQUE ([Code]),
    CONSTRAINT [CK_Company_Code_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Code]) = 1),
    CONSTRAINT [CK_Company_Code_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Code]) = 1),

    -- Nullable columns.
    [ParentCompanyId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [CTK_Company_Id_ParentCompanyId] CHECK ([Id] <> [ParentCompanyId]),
    CONSTRAINT [FK_Company_Company] FOREIGN KEY ([ParentCompanyId]) REFERENCES [dbo].[Company] ([Id])
);
