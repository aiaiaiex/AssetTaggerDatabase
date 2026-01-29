CREATE TABLE [dbo].[Building] (
    [BuildingID] UNIQUEIDENTIFIER CONSTRAINT [DF_Building_BuildingID] DEFAULT (NEWID()) NOT NULL,
    [BuildingName] NVARCHAR(50) NOT NULL,
    [CompanyID] UNIQUEIDENTIFIER NOT NULL,
    [BuildingAddress] NVARCHAR(50) NOT NULL,
    CONSTRAINT [AK_Building_BuildingAddress] UNIQUE ([BuildingAddress]),
    CONSTRAINT [AK_Building_BuildingName] UNIQUE ([BuildingName]),
    CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED ([BuildingID] ASC),
    CONSTRAINT [FK_Building_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);
