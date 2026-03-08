CREATE TABLE [dbo].[Vendor] (
    [VendorID] UNIQUEIDENTIFIER CONSTRAINT [DF_Vendor_VendorID] DEFAULT (NEWID()) NOT NULL,
    [VendorName] NVARCHAR(4000) NOT NULL,
    [VendorAddress] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [AK_Vendor_VendorName_VendorAddress] UNIQUE ([VendorName], [VendorAddress]),
    CONSTRAINT [CK_Vendor_VendorName_MinimumLength] CHECK (LEN([VendorName]) > 0),
    CONSTRAINT [CK_Vendor_VendorName_NoTrailingSpace] CHECK ([VendorName] NOT LIKE ' %' AND [VendorName] NOT LIKE '% '),
    CONSTRAINT [CK_Vendor_VendorAddress_MinimumLength] CHECK (LEN([VendorAddress]) > 0),
    CONSTRAINT [CK_Vendor_VendorAddress_NoTrailingSpace] CHECK ([VendorAddress] NOT LIKE ' %' AND [VendorAddress] NOT LIKE '% '),
    CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED ([VendorID] ASC)
);
