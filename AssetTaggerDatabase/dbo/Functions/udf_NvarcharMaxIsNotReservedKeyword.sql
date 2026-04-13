CREATE FUNCTION [dbo].[udf_NvarcharMaxIsNotReservedKeyword](
    @Value NVARCHAR(MAX)
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
