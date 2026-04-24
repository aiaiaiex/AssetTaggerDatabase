CREATE FUNCTION [dbo].[udf_CalculateCurrentBookValue](
    @PurchasePrice DECIMAL(19, 4),
    @SalvageValue DECIMAL(19, 4),
    @UsefulLife INT,
    @PurchasedAt DATETIME2(3)
)
RETURNS DECIMAL(19, 4) WITH SCHEMABINDING AS
BEGIN
    DECLARE @YearsPassed BIGINT = DATEDIFF_BIG(DD, @PurchasedAt, SYSUTCDATETIME()) / 365;

    IF (@YearsPassed < 0)
        RETURN NULL;

    DECLARE
        @CurrentBookValue DECIMAL(19, 4)
        = @PurchasePrice
        - [dbo].[udf_CalculateAnnualDepreciationExpense](
            @PurchasePrice,
            @SalvageValue,
            @UsefulLife
        )
        * @YearsPassed;

    IF (@CurrentBookValue < @SalvageValue)
        RETURN @SalvageValue;

    RETURN @CurrentBookValue;
END;
