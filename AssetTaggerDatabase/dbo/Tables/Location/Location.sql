CREATE TABLE [dbo].[Location] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Location_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Location_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Location_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Nullable foreign keys.
    [BuildingId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [FK_Location_Building] FOREIGN KEY ([BuildingId]) REFERENCES [dbo].[Building] ([Id]),

    -- Non-nullable columns.
    [Name] NVARCHAR(842) NOT NULL,
    CONSTRAINT [CK_Location_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeywordInNvarchar]([Name]) = 1),
    CONSTRAINT [CK_Location_Name_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespaceInNvarchar]([Name]) = 1),

    -- Composite constraints.
    CONSTRAINT [AK_Location_BuildingId_Name] UNIQUE ([BuildingId], [Name])
);
