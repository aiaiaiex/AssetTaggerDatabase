CREATE TABLE [dbo].[Company] (
    [CompanyID]      UNIQUEIDENTIFIER NOT NULL,
    [CompanyName]    NVARCHAR (50)    NOT NULL,
    [CompanyAddress] NVARCHAR (50)    NOT NULL,
    [CompanyCode]    NCHAR (10)       NOT NULL
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyCode]
    ON [dbo].[Company]([CompanyCode] ASC);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyAddress]
    ON [dbo].[Company]([CompanyAddress] ASC);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyName]
    ON [dbo].[Company]([CompanyName] ASC);
GO

ALTER TABLE [dbo].[Company]
    ADD CONSTRAINT [DEFAULT_Company_CompanyID] DEFAULT (newid()) FOR [CompanyID];
GO

ALTER TABLE [dbo].[Company]
    ADD CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([CompanyID] ASC);
GO

