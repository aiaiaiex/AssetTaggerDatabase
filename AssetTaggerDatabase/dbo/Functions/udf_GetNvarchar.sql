CREATE FUNCTION [dbo].[udf_GetNvarchar](
    @Value NVARCHAR(4000)
)
RETURNS NVARCHAR(4000) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN NULL
        ELSE @Value
    END;
END;
