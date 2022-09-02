-- 任务名: dws_omni_sdk_active_user_di.inc
-- 作者: 胡芬芬
-- 功能：活跃用户 DWS 层轻度汇总表

-- 给用户的活跃和下单行为加上标签
WITH rs_active_user_detali AS (
    SELECT account_id,
        service_group,
        datasource,
        game_id,
        msg_version,
        sdk_version,
        channel,
        host,
        os,
        os_version,
        vendor,
        device_model,
        ip,
        notify_url,
        currency_code,
        header_os,
        header_device,
        country,
        city,
        country_name,
        country_region_name,
        latitude,
        longitude,
        time_zone,
        http_version,
        is_new_user,
        CASE
            WHEN event_name = 'login' THEN 1
            ELSE 0
        END AS is_login,
        CASE
            WHEN event_name = 'create_order' THEN 1
            ELSE 0
        END AS is_create_order_user,
        CASE
            WHEN event_name = 'order_success' THEN 1
            ELSE 0
        END AS is_complete_order_user,
        order_id,
        amount
    FROM dm_omni_sdk.dwb_fact_omni_sdk_active_user_di
    WHERE dt = :dt
),
-- 汇总用户的登录数据和订单数据
rs_active_user_sum AS (
    SELECT account_id,
        service_group,
        datasource,
        game_id,
        msg_version,
        sdk_version,
        channel,
        host,
        os,
        os_version,
        vendor,
        device_model,
        ip,
        notify_url,
        currency_code,
        header_os,
        header_device,
        country,
        city,
        country_name,
        country_region_name,
        latitude,
        longitude,
        time_zone,
        http_version,
        MAX(is_new_user) AS is_new_user,
        SUM(is_create_order_user) AS is_create_order_user,
        SUM(is_complete_order_user) AS is_complete_order_user,
        SUM(is_login) AS login_count,
        SUM(
            CASE
                WHEN is_create_order_user = 1 THEN amount
                ELSE 0
            END
        ) AS create_order_amount,
        SUM(
            CASE
                WHEN is_complete_order_user = 1 THEN amount
                ELSE 0
            END
        ) AS complete_order_amount,
        COUNT(
            CASE
                WHEN is_create_order_user = 1 THEN order_id
                ELSE NULL
            END
        ) AS create_order_cnt,
        COUNT(
            CASE
                WHEN is_complete_order_user = 1 THEN order_id
                ELSE NULL
            END
        ) AS complete_order_cnt
    FROM rs_active_user_detali
    GROUP BY account_id,
        service_group,
        datasource,
        game_id,
        msg_version,
        sdk_version,
        channel,
        host,
        os,
        os_version,
        vendor,
        device_model,
        ip,
        notify_url,
        currency_code,
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
)
INSERT OVERWRITE TABLE dm_omni_sdk.dws_omni_sdk_active_user_di PARTITION (dt = :dt) 
-- 给用户的创建订单和完成订单标签重新赋值并插入结果表
SELECT account_id,
    service_group,
    datasource,
    game_id,
    msg_version,
    sdk_version,
    channel,
    host,
    os,
    os_version,
    vendor,
    device_model,
    ip,
    notify_url,
    currency_code,
    header_os,
    header_device,
    country,
    city,
    country_name,
    country_region_name,
    latitude,
    longitude,
    time_zone,
    http_version,
    is_new_user,
    CASE
        WHEN is_create_order_user > 0 THEN 1
        ELSE 0
    END AS is_create_order_user,
    CASE
        WHEN is_complete_order_user > 0 THEN 1
        ELSE 0
    END AS is_complete_order_user,
    login_count,
    create_order_amount,
    complete_order_amount,
    create_order_cnt,
    complete_order_cnt
FROM rs_active_user_sum;
