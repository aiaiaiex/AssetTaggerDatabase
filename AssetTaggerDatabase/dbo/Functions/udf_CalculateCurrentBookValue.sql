CREATE FUNCTION [dbo].[udf_CalculateCurrentBookValue](
    @AssetPurchasePrice DECIMAL(15, 4),
    @AssetSalvageValue DECIMAL(15, 4),
    @AssetUsefulLife INT,
    @AssetPurchaseDate DATETIME2(3)
)
RETURNS DECIMAL(15, 4) WITH SCHEMABINDING AS
BEGIN
    DECLARE @YearsPassed BIGINT = DATEDIFF_BIG(DD, @AssetPurchaseDate, SYSUTCDATETIME()) / 365;

    IF (@YearsPassed < 0)
        RETURN NULL;

    DECLARE
        @CurrentBookValue DECIMAL(15, 4)
        = @AssetPurchasePrice
        - [dbo].[udf_CalculateAnnualDepreciationExpense](
            @AssetPurchasePrice,
            @AssetSalvageValue,
            @AssetUsefulLife
        )
        * @YearsPassed;

    IF (@CurrentBookValue < @AssetSalvageValue)
        RETURN @AssetSalvageValue;

    RETURN @CurrentBookValue;
END;
