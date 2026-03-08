CREATE TABLE [dbo].[Company] (
    [CompanyID] UNIQUEIDENTIFIER CONSTRAINT [DF_Company_CompanyID] DEFAULT (NEWID()) NOT NULL,
    [ParentCompanyID] UNIQUEIDENTIFIER NULL,
    [CompanyName] NVARCHAR(50) NOT NULL,
    [CompanyAddress] NVARCHAR(50) NOT NULL,
    [CompanyCode] NVARCHAR(5) NOT NULL,
    CONSTRAINT [AK_Company_CompanyName] UNIQUE ([CompanyName]),
    CONSTRAINT [AK_Company_CompanyAddress] UNIQUE ([CompanyAddress]),
    CONSTRAINT [AK_Company_CompanyCode] UNIQUE ([CompanyCode]),
    CONSTRAINT [CK_Company_CompanyName_MinimumLength] CHECK (LEN([CompanyName]) > 0),
    CONSTRAINT [CK_Company_CompanyName_NoTrailingSpace] CHECK ([CompanyName] NOT LIKE ' %' AND [CompanyName] NOT LIKE '% '),
    CONSTRAINT [CK_Company_CompanyAddress_MinimumLength] CHECK (LEN([CompanyAddress]) > 0),
    CONSTRAINT [CK_Company_CompanyAddress_NoTrailingSpace] CHECK ([CompanyAddress] NOT LIKE ' %' AND [CompanyAddress] NOT LIKE '% '),
    CONSTRAINT [CK_Company_CompanyCode_MinimumLength] CHECK (LEN([CompanyCode]) > 0),
    CONSTRAINT [CK_Company_CompanyCode_NoTrailingSpace] CHECK ([CompanyCode] NOT LIKE ' %' AND [CompanyCode] NOT LIKE '% '),
    CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED ([CompanyID] ASC),
    CONSTRAINT [FK_Company_Company] FOREIGN KEY ([ParentCompanyID]) REFERENCES [dbo].[Company] ([CompanyID]),
    CONSTRAINT [CTK_Company_CompanyID_ParentCompanyID] CHECK ([CompanyID] != [ParentCompanyID])
);
