CREATE FUNCTION [dbo].[udf_IsEqualToBitColumn](
    @Value NVARCHAR(1),
    @ColumnValue BIT
)
RETURNS BIT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@Value = '')
            OR (@ColumnValue IS NOT DISTINCT FROM CAST(@Value AS BIT))
        )
            THEN 1
        ELSE 0
    END;
END;
