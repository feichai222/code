-- 任务名: dws_omni_sdk_active_user_di.all
-- 作者: 胡芬芬
-- 功能：活跃用户 DWS 层轻度汇总表

SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;
SET hive.strict.checks.cartesian.product = false;
SET hive.mapred.mode = proceed;

-- 变量
<#-- 定义日期格式和变量 -->
<#setting date_format="yyyy-MM-dd">
<#assign startDate = '2021-10-21'>
<#assign endDate = .now?date?iso_local>

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
        amount,
        dt
    FROM dm_omni_sdk.dwb_fact_omni_sdk_active_user_di
    WHERE  dt BETWEEN '${iterStartDate}' AND '${iterEndDate}'
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
        ) AS complete_order_cnt,
        dt
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
        http_version,
        dt
)
INSERT OVERWRITE TABLE dm_omni_sdk.dws_omni_sdk_active_user_di PARTITION (dt) 
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
    complete_order_cnt,
    dt
FROM rs_active_user_sum;

</#list>
