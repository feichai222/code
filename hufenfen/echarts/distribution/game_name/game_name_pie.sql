SELECT game_name,
    units
FROM (
        SELECT game_name,
            SUM(CAST(units AS DECIMAL(10,2))) AS units
        FROM dm_omni_sdk.dws_app_store_sales_summary_daily_report_di
        WHERE dt >= :startDate
            AND dt <= :endDate
                AND product_type_identifier in ('1','1-B','F1-B', '1F', '1T', '3', '3F', '7', '7F', '7T', 'F1', 'F7')
        GROUP BY game_name
    ) AS rs_rk
