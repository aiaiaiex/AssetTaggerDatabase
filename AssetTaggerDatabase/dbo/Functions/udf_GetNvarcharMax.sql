CREATE FUNCTION [dbo].[udf_GetNvarcharMax](
    @Value NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN NULL
        ELSE @Value
    END;
END;
