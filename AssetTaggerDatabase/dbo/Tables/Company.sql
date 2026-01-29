CREATE TABLE [dbo].[Company] (
    [CompanyID] UNIQUEIDENTIFIER CONSTRAINT [DF_Company_CompanyID] DEFAULT (NEWID()) NOT NULL,
    [ParentCompanyID] UNIQUEIDENTIFIER NULL,
    [CompanyName] NVARCHAR(50) NOT NULL,
    [CompanyAddress] NVARCHAR(50) NOT NULL,
    [CompanyCode] NVARCHAR(5) NOT NULL,
    CONSTRAINT [AK_Company_CompanyName] UNIQUE ([CompanyName]),
    CONSTRAINT [AK_Company_CompanyAddress] UNIQUE ([CompanyAddress]),
    CONSTRAINT [AK_Company_CompanyCode] UNIQUE ([CompanyCode]),
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([CompanyID] ASC),
    CONSTRAINT [FK_Company_Company] FOREIGN KEY ([ParentCompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [CTK_Company_CompanyID_ParentCompanyID] CHECK ([CompanyID] != [ParentCompanyID])
);
