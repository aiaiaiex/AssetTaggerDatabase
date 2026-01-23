CREATE TABLE [dbo].[Vendor] (
    [VendorID]      UNIQUEIDENTIFIER CONSTRAINT [DF_Vendor_VendorID] DEFAULT (newid()) NOT NULL,
    [VendorName]    NVARCHAR (50)    NOT NULL,
    [VendorAddress] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [AK_Vendor_VendorName_VendorAddress] UNIQUE ([VendorName], [VendorAddress]),
    CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED ([VendorID] ASC)
);
