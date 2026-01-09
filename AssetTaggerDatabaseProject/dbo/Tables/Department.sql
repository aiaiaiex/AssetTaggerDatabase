CREATE TABLE [dbo].[Department] (
    [DepartmentID]   UNIQUEIDENTIFIER CONSTRAINT [DEFAULT_Department_DepartmentID] DEFAULT (newid()) NOT NULL,
    [DepartmentName] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Department_DepartmentName]
    ON [dbo].[Department]([DepartmentName] ASC);
GO

