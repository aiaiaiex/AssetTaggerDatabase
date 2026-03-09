CREATE TABLE [dbo].[Department] (
    [DepartmentID] UNIQUEIDENTIFIER CONSTRAINT [DF_Department_DepartmentID] DEFAULT (NEWID()) NOT NULL,
    [DepartmentName] NVARCHAR(4000) NOT NULL,
    [DepartmentInsertDate] DATETIME CONSTRAINT [DF_Department_DepartmentInsertDate] DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT [AK_Department_DepartmentName] UNIQUE ([DepartmentName]),
    CONSTRAINT [CK_Department_DepartmentName_Exclude] CHECK ([DepartmentName] NOT IN ('', '!', 'NULL')),
    CONSTRAINT [CK_Department_DepartmentName_MinimumLength] CHECK (LEN([DepartmentName]) > 0),
    CONSTRAINT [CK_Department_DepartmentName_NoTrailingSpace] CHECK ([DepartmentName] NOT LIKE ' %' AND [DepartmentName] NOT LIKE '% '),
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);
