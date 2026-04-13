CREATE FUNCTION [dbo].[udf_HasNoLeadingAndTrailingWhitespace](
    @Value NVARCHAR(4000)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (
                (@Value NOT LIKE ' %')
                AND (@Value NOT LIKE '% ')
            )
            OR (@Value IS NULL)
        )
            THEN 1
        ELSE 0
    END;
END;
