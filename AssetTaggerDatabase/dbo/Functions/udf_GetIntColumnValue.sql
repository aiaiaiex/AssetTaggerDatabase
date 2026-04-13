CREATE FUNCTION [dbo].[udf_GetIntColumnValue](
    @Value NVARCHAR(11),
    @ColumnValue INT
)
RETURNS INT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @ColumnValue
        ELSE CAST(@Value AS INT)
    END;
END;
