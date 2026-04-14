CREATE FUNCTION [dbo].[udf_GetDefaultDatetime2](
    @Value NVARCHAR(24),
    @DefaultValue DATETIME2(3)
)
RETURNS DATETIME2(3) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE CAST(@Value AS DATETIME2(3))
    END;
END;
