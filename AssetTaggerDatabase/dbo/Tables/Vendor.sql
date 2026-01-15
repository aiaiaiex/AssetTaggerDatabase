CREATE TABLE [dbo].[Vendor] (
    [VendorID]      UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Vendor_VendorID] DEFAULT (newid()) NOT NULL,
    [VendorName]    NVARCHAR (50)    NOT NULL,
    [VendorAddress] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED ([VendorID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Vendor_VendorName_VendorAddress]
    ON [dbo].[Vendor]([VendorName] ASC, [VendorAddress] ASC);

