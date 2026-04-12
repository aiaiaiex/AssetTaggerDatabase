CREATE TABLE [dbo].[Location] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Location_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Location_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY NONCLUSTERED ([Id]),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Location_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Foreign keys.
    [BuildingId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Location_Building] FOREIGN KEY ([BuildingId]) REFERENCES [dbo].[Building] ([Id]),

    -- Non-nullable columns.
    [Address] NVARCHAR(842) NOT NULL,
    CONSTRAINT [AK_Location_Address_BuildingId] UNIQUE ([Address], [BuildingId]),
    CONSTRAINT [CK_Location_Address_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Address]) = 1),
    CONSTRAINT [CK_Location_Address_HasNoLeadingAndTrailingWhitespace] CHECK ([dbo].[udf_HasNoLeadingAndTrailingWhitespace]([Address]) = 1)

);
