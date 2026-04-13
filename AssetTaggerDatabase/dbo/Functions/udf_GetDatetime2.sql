CREATE FUNCTION [dbo].[udf_GetDatetime2](
    @Value NVARCHAR(24)
)
RETURNS DATETIME2(3) WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN NULL
        ELSE CAST(@Value AS DATETIME2(3))
    END;
END;
