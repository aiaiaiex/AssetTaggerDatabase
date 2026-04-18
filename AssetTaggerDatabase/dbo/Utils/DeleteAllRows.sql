-- Delete all rows from all tables in order.
-- Has foreign keys from tables below.
DELETE FROM [dbo].[Asset];
DELETE FROM [dbo].[StoredProcedureLog];
-- Has foreign keys from tables below.
DELETE FROM [dbo].[EndUser];
DELETE FROM [dbo].[Location];
DELETE FROM [dbo].[ProductSet];
-- Has foreign keys from tables below.
DELETE FROM [dbo].[Building];
DELETE FROM [dbo].[Employee];
DELETE FROM [dbo].[Product];
-- Has no foreign keys.
DELETE FROM [dbo].[Category];
DELETE FROM [dbo].[Company];
DELETE FROM [dbo].[Department];
DELETE FROM [dbo].[EndUserRole];
DELETE FROM [dbo].[Manufacturer];
DELETE FROM [dbo].[Role];
DELETE FROM [dbo].[Vendor];

-- Reset identity values back to 0.
-- Has foreign keys from tables below.
DBCC CHECKIDENT('dbo.Asset', RESEED, 0);
DBCC CHECKIDENT('dbo.StoredProcedureLog', RESEED, 0);
-- Has foreign keys from tables below.
DBCC CHECKIDENT('dbo.EndUser', RESEED, 0);
DBCC CHECKIDENT('dbo.Location', RESEED, 0);
DBCC CHECKIDENT('dbo.ProductSet', RESEED, 0);
-- Has foreign keys from tables below.
DBCC CHECKIDENT('dbo.Building', RESEED, 0);
DBCC CHECKIDENT('dbo.Employee', RESEED, 0);
DBCC CHECKIDENT('dbo.Product', RESEED, 0);
-- Has no foreign keys.
DBCC CHECKIDENT('dbo.Category', RESEED, 0);
DBCC CHECKIDENT('dbo.Company', RESEED, 0);
DBCC CHECKIDENT('dbo.Department', RESEED, 0);
DBCC CHECKIDENT('dbo.EndUserRole', RESEED, 0);
DBCC CHECKIDENT('dbo.Manufacturer', RESEED, 0);
DBCC CHECKIDENT('dbo.Role', RESEED, 0);
DBCC CHECKIDENT('dbo.Vendor', RESEED, 0);
