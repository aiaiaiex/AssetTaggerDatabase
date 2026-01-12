CREATE TABLE [dbo].[SubCompany] (
    [ParentCompanyID] UNIQUEIDENTIFIER NOT NULL,
    [CompanyID]       UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_SubCompany] PRIMARY KEY CLUSTERED ([ParentCompanyID] ASC, [CompanyID] ASC),
    CONSTRAINT [FK_SubCompany_Company_CompanyID] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [FK_SubCompany_Company_ParentCompanyID] FOREIGN KEY ([ParentCompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);

