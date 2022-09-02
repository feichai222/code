CREATE VIEW cost.dws_fact_aws_cost_and_usage_reports_view AS
SELECT `identity/LineItemId`,
    `identity/TimeInterval`,
    `bill/InvoiceId`,
    `bill/InvoicingEntity`,
    `bill/BillingEntity`,
    `bill/BillType`,
    `bill/PayerAccountId`,
    `bill/BillingPeriodStartDate`,
    `bill/BillingPeriodEndDate`,
    `lineItem/UsageAccountId`,
    `lineItem/LineItemType`,
    `lineItem/UsageStartDate`,
    `lineItem/UsageEndDate`,
    `lineItem/ProductCode`,
    `lineItem/UsageType`,
    `lineItem/Operation`,
    `lineItem/AvailabilityZone`,
    `lineItem/ResourceId`,
    `lineItem/CurrencyCode`,
    `lineItem/LineItemDescription`,
    `product/ProductName`,
    `product/instanceTypeFamily`,
    `product/region`,
    `product/regionCode`,
    `reservation/StartTime`,
    `reservation/EndTime`,
    `savingsPlan/StartTime`,
    `savingsPlan/EndTime`,    
    SUM(`lineItem/NormalizedUsageAmount`) AS normalized_usage_amount,
    SUM(`lineItem/UsageAmount`) AS usage_amount,
    SUM(`lineItem/NormalizationFactor`) AS normalization_factor,
    SUM(`lineItem/UnblendedCost`) AS unblended_cost,
    SUM(`lineItem/BlendedCost`) AS blended_cost,
    SUM(`reservation/TotalReservedNormalizedUnits`) AS reservation_total_reserved_normalized_units,
    SUM(`reservation/EffectiveCost`) AS reservation_effective_cost,
    SUM(`savingsPlan/SavingsPlanEffectiveCost`) AS savings_plan_effective_cost
FROM cost.dwb_fact_aws_cost_and_usage_reports_view
GROUP BY `identity/LineItemId`,
    `identity/TimeInterval`,
    `bill/InvoiceId`,
    `bill/InvoicingEntity`,
    `bill/BillingEntity`,
    `bill/BillType`,
    `bill/PayerAccountId`,
    `bill/BillingPeriodStartDate`,
    `bill/BillingPeriodEndDate`,
    `lineItem/UsageAccountId`,
    `lineItem/LineItemType`,
    `lineItem/UsageStartDate`,
    `lineItem/UsageEndDate`,
    `lineItem/ProductCode`,
    `lineItem/UsageType`,
    `lineItem/Operation`,
    `lineItem/AvailabilityZone`,
    `lineItem/ResourceId`,
    `lineItem/CurrencyCode`,
    `lineItem/LineItemDescription`,
    `product/ProductName`,
    `product/instanceTypeFamily`,
    `product/region`,
    `product/regionCode`,
    `reservation/StartTime`,
    `reservation/EndTime`,
    `savingsPlan/StartTime`,
    `savingsPlan/EndTime`;