CREATE FUNCTION [dbo].[udf_GetDefaultNvarchar](
    @Value NVARCHAR(4000),
    @DefaultValue NVARCHAR(4000)
)
RETURNS NVARCHAR(4000) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE @Value
    END;
END;
