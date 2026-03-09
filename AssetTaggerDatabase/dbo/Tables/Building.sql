CREATE TABLE [dbo].[Building] (
    [BuildingID] UNIQUEIDENTIFIER CONSTRAINT [DF_Building_BuildingID] DEFAULT (NEWID()) NOT NULL,
    [BuildingName] NVARCHAR(4000) NOT NULL,
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    [BuildingAddress] NVARCHAR(4000) NOT NULL,
    [BuildingInsertDate] DATETIME CONSTRAINT [DF_Building_BuildingInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_Building_BuildingAddress] UNIQUE ([BuildingAddress]),
    CONSTRAINT [AK_Building_BuildingName] UNIQUE ([BuildingName]),
    CONSTRAINT [CK_Building_BuildingName_Exclude] CHECK ([BuildingName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Building_BuildingName_MinimumLength] CHECK (LEN([BuildingName]) > 0),
    CONSTRAINT [CK_Building_BuildingName_NoTrailingSpace] CHECK ([BuildingName] NOT LIKE ' %' AND [BuildingName] NOT LIKE '% '),
    CONSTRAINT [CK_Building_BuildingAddress_Exclude] CHECK ([BuildingAddress] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Building_BuildingAddress_MinimumLength] CHECK (LEN([BuildingAddress]) > 0),
    CONSTRAINT [CK_Building_BuildingAddress_NoTrailingSpace] CHECK ([BuildingAddress] NOT LIKE ' %' AND [BuildingAddress] NOT LIKE '% '),
    CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED ([BuildingID] ASC),
    CONSTRAINT [FK_Building_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);
