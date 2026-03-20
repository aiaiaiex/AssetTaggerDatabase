CREATE TABLE [dbo].[Building] (
    [BuildingNumber] INT IDENTITY (1, 1),
    [BuildingID] UNIQUEIDENTIFIER CONSTRAINT [DF_Building_BuildingID] DEFAULT (NEWID()) NOT NULL,
    [BuildingName] NVARCHAR(850) NOT NULL,
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    [BuildingAddress] NVARCHAR(850) NOT NULL,
    [BuildingInsertDate] DATETIMEOFFSET(3) CONSTRAINT [DF_Building_BuildingInsertDate] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,
    CONSTRAINT [AK_Building_BuildingNumber] UNIQUE CLUSTERED ([BuildingNumber] ASC),
    CONSTRAINT [AK_Building_BuildingAddress] UNIQUE ([BuildingAddress]),
    CONSTRAINT [AK_Building_BuildingName] UNIQUE ([BuildingName]),
    CONSTRAINT [CK_Building_BuildingName_Exclude] CHECK ([BuildingName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Building_BuildingName_MinimumLength] CHECK (LEN([BuildingName]) > 0),
    CONSTRAINT [CK_Building_BuildingName_NoLeadingAndTrailingWhitespace] CHECK ([BuildingName] NOT LIKE ' %' AND [BuildingName] NOT LIKE '% '),
    CONSTRAINT [CK_Building_BuildingAddress_Exclude] CHECK ([BuildingAddress] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Building_BuildingAddress_MinimumLength] CHECK (LEN([BuildingAddress]) > 0),
    CONSTRAINT [CK_Building_BuildingAddress_NoLeadingAndTrailingWhitespace] CHECK ([BuildingAddress] NOT LIKE ' %' AND [BuildingAddress] NOT LIKE '% '),
    CONSTRAINT [PK_Building] PRIMARY KEY NONCLUSTERED ([BuildingID] ASC),
    CONSTRAINT [FK_Building_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);
