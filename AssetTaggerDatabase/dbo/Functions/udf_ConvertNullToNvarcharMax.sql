CREATE FUNCTION [dbo].[udf_ConvertNullToNvarcharMax](
    @Value NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value IS NULL)
            THEN 'NULL'
        ELSE @Value
    END;
END;
