CREATE FUNCTION [dbo].[udf_ConvertNullToNvarchar](
    @Value NVARCHAR(4000)
)
RETURNS NVARCHAR(4000) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value IS NULL)
            THEN 'NULL'
        ELSE @Value
    END;
END;
