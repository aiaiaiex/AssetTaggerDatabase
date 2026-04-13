CREATE FUNCTION [dbo].[udf_GetDecimalColumnValue](
    @Value NVARCHAR(21),
    @ColumnValue DECIMAL(19, 4)
)
RETURNS DECIMAL(19, 4) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @ColumnValue
        ELSE CAST(@Value AS DECIMAL(19, 4))
    END;
END;
