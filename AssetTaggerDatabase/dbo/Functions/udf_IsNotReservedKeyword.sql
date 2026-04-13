CREATE FUNCTION [dbo].[udf_IsNotReservedKeyword](
    @Value NVARCHAR(4000)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value NOT IN ('', 'NULL'))
            OR (@Value IS NULL)
        )
            THEN 1
        ELSE 0
    END;
END;
