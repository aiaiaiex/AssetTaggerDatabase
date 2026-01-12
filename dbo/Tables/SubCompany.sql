CREATE TABLE [dbo].[SubCompany] (
    [SubCompanyID]      UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_SubCompany_SubCompanyID] DEFAULT (newid()) NOT NULL,
    [SubCompanyName]    NVARCHAR (50)    NOT NULL,
    [SubCompanyAddress] NVARCHAR (50)    NOT NULL,
    [SubCompanyCode]    NCHAR (10)       NOT NULL,
    [CompanyID]         UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_SubCompany] PRIMARY KEY CLUSTERED ([SubCompanyID] ASC),
    CONSTRAINT [FK_SubCompany_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_SubCompany_SubCompanyName]
    ON [dbo].[SubCompany]([SubCompanyName] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_SubCompany_SubCompanyAddress]
    ON [dbo].[SubCompany]([SubCompanyAddress] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_SubCompany_SubCompanyCode]
    ON [dbo].[SubCompany]([SubCompanyCode] ASC);

