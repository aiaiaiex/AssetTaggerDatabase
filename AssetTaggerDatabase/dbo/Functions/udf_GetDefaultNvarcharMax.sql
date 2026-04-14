CREATE FUNCTION [dbo].[udf_GetDefaultNvarcharMax](
    @Value NVARCHAR(MAX),
    @DefaultValue NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE @Value
    END;
END;
