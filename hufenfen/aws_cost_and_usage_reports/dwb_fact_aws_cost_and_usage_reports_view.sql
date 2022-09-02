CREATE VIEW cost.dwb_fact_aws_cost_and_usage_reports_view AS
SELECT rs_report.*,
    rs_account_name.account_name,
    SUBSTR(
        `lineItem/UsageStartDate`,
        1,
        10
    ) AS start_dt,
    IF(
        `lineItem/LegalEntity` NOT LIKE 'Amazon%',
        `product/ProductName`,
        `lineItem/ProductCode`
    ) AS product_code,
    REVERSE(
        SUBSTR(
            REVERSE(splitByString(':', `lineItem/UsageType`) [2]),
            POSITION(
                REVERSE(splitByString(':', `lineItem/UsageType`) [2]),
                '.'
            ) + 1,
            LENGTH(`lineItem/UsageType`)
        )
    ) AS usage_type
FROM (
        SELECT *,
            splitByString('/', _path) [4] AS billing_period
        FROM cost.dwd_fact_aws_cost_and_usage_reports
    ) AS rs_report
    LEFT JOIN cost.dim_aws_account_name AS rs_account_name --
    ON `lineItem/UsageAccountId` = rs_account_name.account_id
