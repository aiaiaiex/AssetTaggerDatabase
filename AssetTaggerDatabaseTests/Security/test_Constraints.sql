CREATE SCHEMA [test_Constraints]
AUTHORIZATION [dbo];


GO
EXECUTE Sp_Addextendedproperty @name = N'tSQLt.TestClass', @value = 1, @level0type = N'SCHEMA', @level0name = N'test_Constraints';
