CREATE FUNCTION [dbo].[udf_GetRowsToSkipInInt](
    @RowsToSkipInNvarchar NVARCHAR(10)
)
RETURNS INT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (
            (@RowsToSkipInNvarchar = '')
            OR (@RowsToSkipInNvarchar IS NULL)
        )
            THEN 0
        ELSE CAST(@RowsToSkipInNvarchar AS INT)
    END;
END;
