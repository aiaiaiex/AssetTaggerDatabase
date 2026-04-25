CREATE FUNCTION [dbo].[udf_GetRowsToSkip](
    @RowsToSkipInNvarchar NVARCHAR(19)
)
RETURNS BIGINT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@RowsToSkipInNvarchar = '')
            THEN 0
        ELSE CAST(@RowsToSkipInNvarchar AS BIGINT)
    END;
END;
