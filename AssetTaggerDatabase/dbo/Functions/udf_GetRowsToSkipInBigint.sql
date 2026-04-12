CREATE FUNCTION [dbo].[udf_GetRowsToSkipInBigint](
    @RowsToSkipInNvarchar NVARCHAR(19)
)
RETURNS BIGINT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@RowsToSkipInNvarchar = '')
            OR (@RowsToSkipInNvarchar IS NULL)
        )
            THEN 0
        ELSE CAST(@RowsToSkipInNvarchar AS BIGINT)
    END;
END;
