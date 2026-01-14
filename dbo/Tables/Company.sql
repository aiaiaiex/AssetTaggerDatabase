CREATE TABLE [dbo].[Company] (
    [CompanyID]      UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Company_CompanyID] DEFAULT (newid()) NOT NULL,
    [CompanyName]    NVARCHAR (50)    NOT NULL,
    [CompanyAddress] NVARCHAR (50)    NOT NULL,
    [CompanyCode]    NVARCHAR (5)     NOT NULL,
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([CompanyID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyCode]
    ON [dbo].[Company]([CompanyCode] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyName]
    ON [dbo].[Company]([CompanyName] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Company_CompanyAddress]
    ON [dbo].[Company]([CompanyAddress] ASC);

