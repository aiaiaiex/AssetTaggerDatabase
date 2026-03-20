CREATE TABLE [dbo].[Vendor] (
    [VendorNumber] INT IDENTITY (1, 1),
    [VendorID] UNIQUEIDENTIFIER CONSTRAINT [DF_Vendor_VendorID] DEFAULT (NEWID()) NOT NULL,
    [VendorName] NVARCHAR(850) NOT NULL,
    [VendorAddress] NVARCHAR(850) NOT NULL,
    [VendorInsertDate] DATETIMEOFFSET(3) CONSTRAINT [DF_Vendor_VendorInsertDate] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,
    CONSTRAINT [AK_Vendor_VendorNumber] UNIQUE CLUSTERED ([VendorNumber] ASC),
    CONSTRAINT [AK_Vendor_VendorName] UNIQUE ([VendorName]),
    CONSTRAINT [AK_Vendor_VendorAddress] UNIQUE ([VendorAddress]),
    CONSTRAINT [CK_Vendor_VendorName_Exclude] CHECK ([VendorName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Vendor_VendorName_MinimumLength] CHECK (LEN([VendorName]) > 0),
    CONSTRAINT [CK_Vendor_VendorName_NoLeadingAndTrailingWhitespace] CHECK ([VendorName] NOT LIKE ' %' AND [VendorName] NOT LIKE '% '),
    CONSTRAINT [CK_Vendor_VendorAddress_Exclude] CHECK ([VendorAddress] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Vendor_VendorAddress_MinimumLength] CHECK (LEN([VendorAddress]) > 0),
    CONSTRAINT [CK_Vendor_VendorAddress_NoLeadingAndTrailingWhitespace] CHECK ([VendorAddress] NOT LIKE ' %' AND [VendorAddress] NOT LIKE '% '),
    CONSTRAINT [PK_Vendor] PRIMARY KEY NONCLUSTERED ([VendorID] ASC)
);
