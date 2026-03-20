CREATE TABLE [dbo].[Department] (
    [DepartmentNumber] INT IDENTITY (1, 1),
    [DepartmentID] UNIQUEIDENTIFIER CONSTRAINT [DF_Department_DepartmentID] DEFAULT (NEWID()) NOT NULL,
    [DepartmentName] NVARCHAR(850) NOT NULL,
    [DepartmentInsertDate] DATETIMEOFFSET(3) CONSTRAINT [DF_Department_DepartmentInsertDate] DEFAULT (SYSDATETIMEOFFSET()) NOT NULL,
    CONSTRAINT [AK_Department_DepartmentNumber] UNIQUE CLUSTERED ([DepartmentNumber] ASC),
    CONSTRAINT [AK_Department_DepartmentName] UNIQUE ([DepartmentName]),
    CONSTRAINT [CK_Department_DepartmentName_Exclude] CHECK ([DepartmentName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Department_DepartmentName_MinimumLength] CHECK (LEN([DepartmentName]) > 0),
    CONSTRAINT [CK_Department_DepartmentName_NoLeadingAndTrailingWhitespace] CHECK ([DepartmentName] NOT LIKE ' %' AND [DepartmentName] NOT LIKE '% '),
    CONSTRAINT [PK_Department] PRIMARY KEY NONCLUSTERED ([DepartmentID] ASC)
);
