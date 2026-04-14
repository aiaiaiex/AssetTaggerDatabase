CREATE FUNCTION [dbo].[udf_GetDefaultDecimal](
    @Value NVARCHAR(21),
    @DefaultValue DECIMAL(19, 4)
)
RETURNS DECIMAL(19, 4) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE CAST(@Value AS DECIMAL(19, 4))
    END;
END;
