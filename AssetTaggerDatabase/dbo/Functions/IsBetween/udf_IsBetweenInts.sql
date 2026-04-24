CREATE FUNCTION [dbo].[udf_IsBetweenInts](
    @FromValue NVARCHAR(11),
    @Value INT,
    @ToValue NVARCHAR(11)
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (
                (@FromValue = '')
                OR (CAST(@FromValue AS INT) <= @Value)
                OR (@FromValue IS NULL AND @Value IS NULL)
            )
            AND
            (
                (@ToValue = '')
                OR (@Value <= CAST(@ToValue AS INT))
                OR (@Value IS NULL AND @ToValue IS NULL)
            )
        )
            THEN 1
        ELSE 0
    END;
END;
