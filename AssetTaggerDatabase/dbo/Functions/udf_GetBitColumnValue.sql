CREATE FUNCTION [dbo].[udf_GetBitColumnValue](
    @Value NVARCHAR(1),
    @ColumnValue BIT
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @ColumnValue
        ELSE CAST(@Value AS BIT)
    END;
END;
