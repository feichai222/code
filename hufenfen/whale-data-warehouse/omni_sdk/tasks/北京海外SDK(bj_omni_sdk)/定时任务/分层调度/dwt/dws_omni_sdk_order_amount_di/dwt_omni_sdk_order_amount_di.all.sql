-- 任务名: dwt_omni_sdk_order_amount_di
-- 作者: 翟旭亮
-- 功能：订单主题汇总表
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;
-- 变量
<#-- 定义日期格式和变量 -->
<#setting date_format="yyyy-MM-dd">
<#assign startDate = '2021-09-17'>
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

INSERT OVERWRITE TABLE dm_omni_sdk.dwt_omni_sdk_order_amount_di PARTITION (dt)
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
    country_region_name,
    dt
FROM dm_omni_sdk.dwb_fact_omni_sdk_order_detail_di
WHERE dt BETWEEN '${iterStartDate}' AND '${iterEndDate}'
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
    country_region_name,
    dt;

</#list>
