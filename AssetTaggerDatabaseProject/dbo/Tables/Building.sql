CREATE TABLE [dbo].[Building] (
    [BuilidingID]     UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Building_BuilidingID] DEFAULT (newid()) NOT NULL,
    [BuilidingName]   NVARCHAR (50)    NOT NULL,
    [CompanyID]       UNIQUEIDENTIFIER NOT NULL,
    [SubCompanyID]    UNIQUEIDENTIFIER NOT NULL,
    [BuildingAddress] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED ([BuilidingID] ASC),
    CONSTRAINT [CK_SubORCompanyIDNotNull] CHECK ([CompanyID] IS NOT NULL OR [SubCompanyID] IS NOT NULL),
    CONSTRAINT [FK_Building_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_Building_SubCompany] FOREIGN KEY ([SubCompanyID]) REFERENCES [dbo].[SubCompany] ([SubCompanyID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Building_BuildingAddress]
    ON [dbo].[Building]([BuildingAddress] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Building_BuildingName]
    ON [dbo].[Building]([BuilidingName] ASC);

