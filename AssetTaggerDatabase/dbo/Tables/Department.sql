CREATE TABLE [dbo].[Department] (
    -- Columns with default values.
    [RowNumber] INT IDENTITY (1, 1),
    CONSTRAINT [AK_Department_RowNumber] UNIQUE CLUSTERED ([RowNumber] ASC),

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Department_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY NONCLUSTERED ([Id] ASC),

    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Department_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    -- Non-nullable columns.
    [Name] NVARCHAR(850) NOT NULL,
    CONSTRAINT [AK_Department_Name] UNIQUE ([Name]),
    CONSTRAINT [CK_Department_Name_IsNotReservedKeyword] CHECK ([dbo].[udf_IsNotReservedKeyword]([Name]) = 1),
    CONSTRAINT [CK_Department_Name_NoLeadingAndTrailingWhitespace] CHECK ([Name] NOT LIKE ' %' AND [Name] NOT LIKE '% ')
);
