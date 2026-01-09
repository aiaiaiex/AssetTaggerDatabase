CREATE TABLE [dbo].[Department] (
    [DepartmentID]   UNIQUEIDENTIFIER NOT NULL,
    [DepartmentName] NVARCHAR (50)    NOT NULL
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_Department_DepartmentName]
    ON [dbo].[Department]([DepartmentName] ASC);
GO

ALTER TABLE [dbo].[Department]
    ADD CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([DepartmentID] ASC);
GO

