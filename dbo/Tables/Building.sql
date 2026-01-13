CREATE TABLE [dbo].[Building] (
    [BuildingID]      UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Building_BuildingID] DEFAULT (newid()) NOT NULL,
    [BuildingName]    NVARCHAR (50)    NOT NULL,
    [CompanyID]       UNIQUEIDENTIFIER NOT NULL,
    [BuildingAddress] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED ([BuildingID] ASC),
    CONSTRAINT [FK_Building_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Building_BuildingAddress]
    ON [dbo].[Building]([BuildingAddress] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Building_BuildingName]
    ON [dbo].[Building]([BuildingName] ASC);

