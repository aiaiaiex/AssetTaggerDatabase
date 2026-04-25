CREATE FUNCTION [dbo].[udf_GetDefaultDecimal](
    @Value NVARCHAR(17),
    @DefaultValue DECIMAL(15, 4)
)
RETURNS DECIMAL(15, 4) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE CAST(@Value AS DECIMAL(15, 4))
    END;
END;
