CREATE FUNCTION [dbo].[udf_GetDefaultUniqueidentifier](
    @Value NVARCHAR(36),
    @DefaultValue UNIQUEIDENTIFIER
)
RETURNS UNIQUEIDENTIFIER WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @DefaultValue
        ELSE CAST(@Value AS UNIQUEIDENTIFIER)
    END;
END;
