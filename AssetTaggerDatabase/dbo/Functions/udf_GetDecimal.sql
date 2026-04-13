CREATE FUNCTION [dbo].[udf_GetDecimal](
    @Value NVARCHAR(21)
)
RETURNS DECIMAL(19, 4) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN NULL
        ELSE CAST(@Value AS DECIMAL(19, 4))
    END;
END;
