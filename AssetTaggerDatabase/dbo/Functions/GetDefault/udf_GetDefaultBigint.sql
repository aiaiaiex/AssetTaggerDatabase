CREATE FUNCTION [dbo].[udf_GetDefaultBigint](
    @Value NVARCHAR(20),
    @DefaultValue BIGINT
)
RETURNS BIGINT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE CAST(@Value AS BIGINT)
    END;
END;
