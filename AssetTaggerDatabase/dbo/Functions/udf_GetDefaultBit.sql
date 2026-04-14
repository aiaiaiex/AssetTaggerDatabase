CREATE FUNCTION [dbo].[udf_GetDefaultBit](
    @Value NVARCHAR(1)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN 0
        ELSE CAST(@Value AS BIT)
    END;
END;
