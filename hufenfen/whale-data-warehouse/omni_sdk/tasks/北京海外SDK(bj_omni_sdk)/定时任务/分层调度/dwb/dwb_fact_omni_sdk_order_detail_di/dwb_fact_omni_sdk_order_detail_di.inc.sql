SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;
WITH rs_create_order AS (
    SELECT account_id,
        order_id,
        from_unixtime(
            CAST(time_ms / 1000 AS int),
            'yyyy-MM-dd HH:mm:ss'
        ) AS create_order_time,
        amount AS create_order_amount,
        currency_code,
        channel,
        os,
        os_version,
        vendor,
        device_model,
        service_group,
        datasource,
        game_id,
        msg_version,
        sdk_version,
        device_id,
        host,
        event_group,
        another_device_id,
        ip,
        notify_url,
        role_id,
        CASE
            WHEN android = 'true' THEN 'android'
            WHEN ios = 'true' THEN 'ios'
            ELSE NULL
        END AS header_os,
        CASE
            WHEN desktop = 'true' THEN 'desktop'
            WHEN smarttv = 'true' THEN 'smarttv'
            WHEN tablet = 'true' THEN 'tablet'
            WHEN mobile = 'true' THEN 'other mobile'
            ELSE NULL
        END AS header_device,
        country,
        city,
        rs_country_dim.ch_name AS country_name,
        country_region_name,
        latitude,
        longitude,
        time_zone,
        http_version,
        dt
    FROM dw_omni_sdk.dwd_fact_omni_sdk_order_create_di AS rs_order
        LEFT JOIN (
            SELECT code_2,
                ch_name
            FROM dm_omni_sdk.dim_wiki_country_code
        ) AS rs_country_dim ON rs_order.country = rs_country_dim.code_2
    WHERE dt BETWEEN date_add(:dt, -1) AND :dt
),
rs_complete_order AS (
    SELECT order_id,
        from_unixtime(
            CAST(time_ms / 1000 AS bigint),
            'yyyy-MM-dd HH:mm:ss'
        ) AS complete_order_time,
        amount AS complete_order_amount
    FROM dw_omni_sdk.dwd_fact_omni_sdk_order_complete_di AS rs_order
    WHERE dt = :dt
)
INSERT OVERWRITE TABLE dm_omni_sdk.dwb_fact_omni_sdk_order_detail_di PARTITION(dt = :dt)
SELECT account_id,
    order_id,
    create_order_time,
    complete_order_time,
    create_order_amount,
    complete_order_amount,
    currency_code,
    channel,
    os,
    os_version,
    vendor,
    device_model,
    service_group,
    datasource,
    game_id,
    msg_version,
    sdk_version,
    device_id,
    host,
    event_group,
    another_device_id,
    ip,
    notify_url,
    role_id,
    header_os,
    header_device,
    country,
    city,
    country_name,
    country_region_name,
    latitude,
    longitude,
    time_zone,
    http_version
FROM (
        SELECT rs_create_order.*,
            rs_complete_order.complete_order_time,
            rs_complete_order.complete_order_amount
        FROM rs_create_order
            LEFT JOIN rs_complete_order --
            ON rs_create_order.order_id = rs_complete_order.order_id
    ) AS rs_ALL_order
WHERE dt = :dt;