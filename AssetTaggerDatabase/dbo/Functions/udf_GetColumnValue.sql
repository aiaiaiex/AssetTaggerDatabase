-- Returns @ColumnValue when @Value is '', which is our user-defined reserved keyword that means optional.
-- Otherwise, returns @Value.
CREATE FUNCTION [dbo].[udf_GetColumnValue](
    @Value SQL_VARIANT,
    @ColumnValue SQL_VARIANT
)
RETURNS SQL_VARIANT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@Value = '')
            THEN @ColumnValue
        ELSE @Value
    END;
END;
