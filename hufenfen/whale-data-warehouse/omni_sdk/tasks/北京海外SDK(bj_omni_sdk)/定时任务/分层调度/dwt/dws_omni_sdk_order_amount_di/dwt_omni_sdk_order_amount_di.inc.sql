-- 任务名: dwt_omni_sdk_order_amount_di
-- 作者: 翟旭亮
-- 功能：订单主题汇总表
INSERT OVERWRITE TABLE dm_omni_sdk.dwt_omni_sdk_order_amount_di PARTITION (dt = :dt)
SELECT SUM(create_order_amount) AS create_order_amount,
    SUM(complete_order_amount) AS complete_order_amount,
    COUNT(create_order_amount) AS create_order_cnt,
    COUNT(complete_order_amount) AS complete_order_cnt,
    channel,
    os,
    os_version,
    vendor,
    device_model,
    game_id,
    sdk_version,
    host,
    notify_url,
    currency_code,
    header_os,
    header_device,
    country,
    city,
    country_name,
    country_region_name
FROM dm_omni_sdk.dwb_fact_omni_sdk_order_detail_di
WHERE dt = :dt
GROUP BY channel,
    os,
    os_version,
    vendor,
    device_model,
    game_id,
    sdk_version,
    host,
    notify_url,
    currency_code,
    header_os,
    header_device,
    country,
    city,
    country_name,
    country_region_name;
