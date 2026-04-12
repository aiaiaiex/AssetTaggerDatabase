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
    CONSTRAINT [CK_Building_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Name]) = 1),
    CONSTRAINT [CK_Building_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Name]) = 1),

    [Address] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Building_Address] UNIQUE ([Address]),
    CONSTRAINT [CK_Building_Address_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Address]) = 1),
    CONSTRAINT [CK_Building_Address_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Address]) = 1)
);
