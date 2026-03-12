CREATE TABLE [dbo].[Manufacturer] (
    [ManufacturerNumber] INT IDENTITY (1, 1),
    [ManufacturerID] UNIQUEIDENTIFIER CONSTRAINT [DF_Manufacturer_ManufacturerID] DEFAULT (NEWID()) NOT NULL,
    [ManufacturerName] NVARCHAR(4000) NOT NULL,
    [ManufacturerInsertDate] DATETIME CONSTRAINT [DF_Manufacturer_ManufacturerInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_Manufacturer_ManufacturerNumber] UNIQUE CLUSTERED ([ManufacturerNumber] ASC),
    CONSTRAINT [PK_Manufacturer] PRIMARY KEY NONCLUSTERED ([ManufacturerID] ASC),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_Exclude] CHECK ([ManufacturerName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_MinimumLength] CHECK (LEN([ManufacturerName]) > 0),
    CONSTRAINT [CK_Manufacturer_ManufacturerName_NoTrailingWhitespace] CHECK ([ManufacturerName] NOT LIKE ' %' AND [ManufacturerName] NOT LIKE '% '),
    CONSTRAINT [AK_Manufacturer_ManufacturerName] UNIQUE NONCLUSTERED ([ManufacturerName] ASC)
);
