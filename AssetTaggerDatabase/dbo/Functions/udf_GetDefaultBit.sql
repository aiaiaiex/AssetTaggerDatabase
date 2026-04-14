CREATE FUNCTION [dbo].[udf_GetDefaultBit](
    @Value NVARCHAR(1),
    @DefaultValue BIT
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE CAST(@Value AS BIT)
    END;
END;
