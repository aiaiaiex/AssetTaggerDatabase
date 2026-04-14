CREATE FUNCTION [dbo].[udf_GetDefaultInt](
    @Value NVARCHAR(11),
    @DefaultValue INT
)
RETURNS INT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE CAST(@Value AS INT)
    END;
END;
