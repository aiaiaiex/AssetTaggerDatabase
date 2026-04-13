CREATE FUNCTION [dbo].[udf_HasNoWhitespace](
    @Value NVARCHAR(4000)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (CHARINDEX(' ', @Value) = 0)
            OR @Value IS NULL
        )
            THEN 1
        ELSE 0
    END;
END;
