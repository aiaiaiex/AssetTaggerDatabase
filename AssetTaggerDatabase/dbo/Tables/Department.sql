CREATE TABLE [dbo].[Department] (
    [DepartmentID]   UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Department_DepartmentID] DEFAULT (newid()) NOT NULL,
    [DepartmentName] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [AK_Department_DepartmentName] UNIQUE ([DepartmentName]),
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);
