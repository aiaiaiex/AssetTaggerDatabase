CREATE TABLE [dbo].[Company] (
    [CompanyID]       UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Company_CompanyID] DEFAULT (newid()) NOT NULL,
    [ParentCompanyID] UNIQUEIDENTIFIER NULL,
    [CompanyName]     NVARCHAR (50)    NOT NULL,
    [CompanyAddress]  NVARCHAR (50)    NOT NULL,
    [CompanyCode]     NVARCHAR (5)     NOT NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([CompanyID] ASC),
    CONSTRAINT [FK_Company_Company] FOREIGN KEY ([ParentCompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyName]
    ON [dbo].[Company]([CompanyName] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyAddress]
    ON [dbo].[Company]([CompanyAddress] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyCode]
    ON [dbo].[Company]([CompanyCode] ASC);

