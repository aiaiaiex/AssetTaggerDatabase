CREATE FUNCTION [dbo].[udf_GetRowsToReturnInBigint](
    @RowsToReturnInNvarchar NVARCHAR(19)
)
RETURNS BIGINT WITH SCHEMABINDING AS
BEGIN
    RETURN CASE
        WHEN (@RowsToReturnInNvarchar = '')
            -- Fetch the next 9,223,372,036,854,775,807 rows which is the upper limit of BIGINT, the data type of RowNumber.
            -- See more:
            -- https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql
            THEN 9223372036854775807
        ELSE CAST(@RowsToReturnInNvarchar AS BIGINT)
    END;
END;
