CREATE TABLE [dbo].[Permission] (
    -- Non-nullable columns with default values.
    [CreatedAt] DATETIME2(3) CONSTRAINT [DF_Permission_CreatedAt] DEFAULT (SYSUTCDATETIME()) NOT NULL,

    [Id] UNIQUEIDENTIFIER CONSTRAINT [DF_Permission_Id] DEFAULT (NEWID()) NOT NULL,
    CONSTRAINT [PK_Permission] PRIMARY KEY NONCLUSTERED ([Id]),

    [RowNumber] BIGINT IDENTITY (1, 1),
    CONSTRAINT [AK_Permission_RowNumber] UNIQUE CLUSTERED ([RowNumber]),

    -- Non-nullable foreign keys.
    [RoleId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Permission_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([Id]),

    -- Non-nullable columns.
    [Operation] NVARCHAR(6) NOT NULL,
    CONSTRAINT [CK_Permission_Operation] CHECK ([Operation] IN (
        'Create',
        'Read',
        'Update',
        'Delete'
    )),

    [TableName] NVARCHAR(836) NOT NULL,
    CONSTRAINT [CK_Permission_TableName] CHECK ([TableName] IN (
        'Asset',
        'Building',
        'Category',
        'Company',
        'Department',
        'Employee',
        'EndUser',
        'InHouseUnit',
        'Job',
        'Location',
        'Log',
        'Manufacturer',
        'Permission',
        'Product',
        'ProductSet',
        'Role',
        'Vendor'
    )),

    -- Composite constraints.
    CONSTRAINT [AK_Permission_RoleId_Operation] UNIQUE ([RoleId], [Operation], [TableName]),

    CONSTRAINT [CK_Permission_TableName_Operation] CHECK (
        1 = CASE [TableName]
            -- Log has no create permission because every call to stored procedures should be logged.
            -- Log has no update and delete permissions because it doesn't have update and delete stored procedures to make it immutable.
            WHEN 'Log'
                THEN CASE [Operation]
                    WHEN 'Read'
                        THEN 1
                    ELSE 0
                END
            ELSE 1
        END
    )
);
