-- 2021-12-24 之前的数据为旧格式，不存在 android、ios、desktop、smarttv、tablet、mobile、country
-- city、country_region、country_region_name、latitude、longitude、time_zone、http_version 等字段
-- 2021-12-24 至 2021-12-28 日新旧格式并存
-- 2021-12-28 之后全为新格式

SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions = 400;
SET hive.exec.max.dynamic.partitions.pernode = 400;

-- 变量
<#-- 定义日期格式和变量 -->
<#setting date_format="yyyy-MM-dd">
<#assign startDate = '2021-10-21'>
<#assign endDate = '2021-12-28'>

<#-- 单次执行的天数, 最大 400 不能修改 -->
<#assign batchDays = 400>

<#-- 计算需要进行几次循环 -->
<#assign dayDiff = DateUtil.dayDiff(startDate?date, endDate?date)>
<#assign iterTimes = (dayDiff/batchDays)?int>
<#-- 如果向下取整之后变小了, 说明没有整除, 需要加一 -->
<#if iterTimes < dayDiff/batchDays>
<#assign iterTimes = iterTimes + 1>
</#if>

<#-- 开始循环 -->
<#list 1..iterTimes as index>
<#assign iterStartDate = DateUtil.addDays(startDate?string, (index - 1) * batchDays)>
<#assign iterEndDate = DateUtil.addDays(startDate?string, index * batchDays)>
<#-- 只要不是循环的最后一次, 都需要对结尾的日期减一 -->
<#if !index?is_last>
<#assign iterEndDate = DateUtil.addDays(startDate?string, index * batchDays - 1)>
</#if>
<#-- 循环内的结束日期不能超过循环外的结尾日期 -->
<#if iterEndDate?date gt endDate?date>
<#assign iterEndDate = endDate?date>
</#if>


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
        CASE
            WHEN country IS NULL THEN rs_country_dim.ch_name --老埋点
            WHEN country IS NOT NULL THEN rs_country_dim2.ch_name --新埋点
            ELSE NULL
        END AS country_name,
        country_region_name,
        latitude,
        longitude,
        time_zone,
        http_version,
        dt
    FROM dw_omni_sdk.dwd_fact_omni_sdk_order_create_di AS rs_order
        LEFT JOIN (
            SELECT whales_name,
                ch_name
            FROM dm_omni_sdk.dim_wiki_country_code
        ) AS rs_country_dim -- 取老埋点国家对应维基中文名称
        ON ip_locate(ip)['country'] = rs_country_dim.whales_name
        LEFT JOIN (
            SELECT code_2,
                ch_name
            FROM dm_omni_sdk.dim_wiki_country_code
        ) AS rs_country_dim2 -- 取新埋点国家对应维基中文名称
        ON rs_order.country = rs_country_dim2.code_2
    WHERE dt BETWEEN '${iterStartDate}' AND '${iterEndDate}'
),
rs_complete_order AS (
    SELECT 
        order_id,
        from_unixtime(
            CAST(time_ms / 1000 AS bigint),
            'yyyy-MM-dd HH:mm:ss'
        ) AS complete_order_time,
        amount AS complete_order_amount,
        dt
    FROM dw_omni_sdk.dwd_fact_omni_sdk_order_complete_di AS rs_order
    WHERE dt BETWEEN '${iterStartDate}' AND '${iterEndDate}'
)
INSERT OVERWRITE TABLE dm_omni_sdk.dwb_fact_omni_sdk_order_detail_di PARTITION(dt)
SELECT rs_create_order.account_id,
    rs_create_order.order_id,
    rs_create_order.create_order_time,
    rs_complete_order.complete_order_time,
    rs_create_order.create_order_amount,
    rs_complete_order.complete_order_amount,
    rs_create_order.currency_code,
    rs_create_order.channel,
    rs_create_order.os,
    rs_create_order.os_version,
    rs_create_order.vendor,
    rs_create_order.device_model,
    rs_create_order.service_group,
    rs_create_order.datasource,
    rs_create_order.game_id,
    rs_create_order.msg_version,
    rs_create_order.sdk_version,
    rs_create_order.device_id,
    rs_create_order.host,
    rs_create_order.event_group,
    rs_create_order.another_device_id,
    rs_create_order.ip,
    rs_create_order.notify_url,
    rs_create_order.role_id,
    rs_create_order.header_os,
    rs_create_order.header_device,
    rs_create_order.country,
    rs_create_order.city,
    rs_create_order.country_name,
    rs_create_order.country_region_name,
    rs_create_order.latitude,
    rs_create_order.longitude,
    rs_create_order.time_zone,
    rs_create_order.http_version,
    IF(rs_complete_order.dt IS NULL, rs_create_order.dt, rs_complete_order.dt) AS dt
FROM rs_create_order
    LEFT JOIN rs_complete_order --
    ON rs_create_order.order_id = rs_complete_order.order_id

</#list>
